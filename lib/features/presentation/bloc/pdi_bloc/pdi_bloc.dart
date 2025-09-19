import 'package:bloc/bloc.dart';
import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:earningfish/features/domain/usecase/pdi_usecase.dart';
import 'package:earningfish/features/presentation/widgets/pdi_widget/pdi_data.dart';
import 'package:flutter/material.dart';

part 'pdi_event.dart';
part 'pdi_state.dart';

class PDIBloc extends Bloc<PDIEvent, PDIState> {
  final CreatePDIUseCase createPDIUseCase;
  final AuthLocalDatasource localDS;

  PDIBloc({required this.createPDIUseCase, required this.localDS}) : super(PDIInitial()) {
    on<UpdateInitialDetailsEvent>(_onUpdateInitialDetails);
    on<UpdateVehicleDetailsEvent>(_onUpdateVehicleDetails);
    on<UpdateBodyInspectionEvent>(_onUpdateBodyInspection);
    on<UpdateWheelsInspectionEvent>(_onUpdateWheelsInspection);
    on<SubmitPDIEvent>(_onSubmitPDI);
  }

  PDIData _currentData = const PDIData();

  void _onUpdateInitialDetails(
    UpdateInitialDetailsEvent event,
    Emitter<PDIState> emit,
  ) {
    _currentData = _currentData.copyWith(
      modelName: event.modelName,
      modelVariant: event.modelVariant,
      chassisNo: event.chassisNo,
      engineNo: event.engineNo,
      keyNo: event.keyNo,
      batteryMake: event.batteryMake,
      batterySerialNo: event.batterySerialNo,
      dateOfReceipt: event.dateOfReceipt,
      pdiKms: event.pdiKms,
      bodyShade: event.bodyShade,
    );
    emit(PDIUpdated(_currentData));
  }

  void _onUpdateVehicleDetails(
    UpdateVehicleDetailsEvent event,
    Emitter<PDIState> emit,
  ) {
    _currentData = _currentData.copyWith(
      dateOfInspection: event.dateOfInspection,
      tyreFrtRh: event.tyreFrtRh,
      tyreFrtLh: event.tyreFrtLh,
      tyreRrRh: event.tyreRrRh,
      tyreRrLh: event.tyreRrLh,
      spareWheel: event.spareWheel,
    );
    emit(PDIUpdated(_currentData));
  }

  void _onUpdateBodyInspection(
    UpdateBodyInspectionEvent event,
    Emitter<PDIState> emit,
  ) {
    _currentData = _currentData.copyWith(
      bodyPaintCondition: event.bodyPaintCondition,
      dentsDefects: event.dentsDefects,
      doorsAlignment: event.doorsAlignment,
      doorsNoise: event.doorsNoise,
      tailGateNoise: event.tailGateNoise,
      remoteOperation: event.remoteOperation,
    );
    emit(PDIUpdated(_currentData));
  }

  void _onUpdateWheelsInspection(
    UpdateWheelsInspectionEvent event,
    Emitter<PDIState> emit,
  ) {
    _currentData = _currentData.copyWith(
      tyrePressure: event.tyrePressure,
      tyreFitment: event.tyreFitment,
      spareWheelUnlocking: event.spareWheelUnlocking,
      toolsAvailability: event.toolsAvailability,
      tailGateOperation: event.tailGateOperation,
      hsrpAvailability: event.hsrpAvailability,
    );
    emit(PDIUpdated(_currentData));
  }

  Future<void> _onSubmitPDI(
    SubmitPDIEvent event,
    Emitter<PDIState> emit,
  ) async {
    if (!_currentData.isComplete) {
      emit(PDiFailureState(message: "Please complete all PDI fields."));
      return;
    }

    emit(PDiLoaidngState());

    try {
      final uid = await localDS.get();
      if (uid == null) {
        return emit( PDiFailureState(message: "Failed to create PDI. user not found Please login again."));
      }

      final pdiModel = PDIModel(
        modelName: _currentData.modelName,
        modelVariant: _currentData.modelVariant,
        chassisNo: _currentData.chassisNo,
        engineNo: _currentData.engineNo,
        keyNo: _currentData.keyNo,
        batteryMake: _currentData.batteryMake,
        batterySerialNo: _currentData.batterySerialNo,
        dateOfReceipt: _currentData.dateOfReceipt,
        pdiKms: _currentData.pdiKms,
        bodyShade: _currentData.bodyShade,
        dateOfInspection: _currentData.dateOfInspection,
        tyreFrtRh: _currentData.tyreFrtRh,
        tyreFrtLh: _currentData.tyreFrtLh,
        tyreRrRh: _currentData.tyreRrRh,
        tyreRrLh: _currentData.tyreRrLh,
        spareWheel: _currentData.spareWheel,
        bodyPaintCondition: _currentData.bodyPaintCondition,
        dentsDefects: _currentData.dentsDefects,
        doorsAlignment: _currentData.doorsAlignment,
        doorsNoise: _currentData.doorsNoise,
        tailGateNoise: _currentData.tailGateNoise,
        remoteOperation: _currentData.remoteOperation,
        tyrePressure: _currentData.tyrePressure,
        tyreFitment: _currentData.tyreFitment,
        spareWheelUnlocking: _currentData.spareWheelUnlocking,
        toolsAvailability: _currentData.toolsAvailability,
        tailGateOperation: _currentData.tailGateOperation,
        hsrpAvailability: _currentData.hsrpAvailability,
        uid: uid,
        status: 'pending',
      );

      final success = await createPDIUseCase.execute(pdi: pdiModel);

      if (success) {
        emit(PDiSuccessState());
      } else {
        emit(
          PDiFailureState(message: "Failed to create PDI. Please try again."),
        );
      }
    } catch (e) {
      emit(PDiFailureState(message: e.toString()));
    }
  }

  PDIData get currentData => _currentData;
}
