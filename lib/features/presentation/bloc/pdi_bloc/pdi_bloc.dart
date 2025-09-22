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

  PDIBloc({
    required this.createPDIUseCase,
    required this.localDS,
  }) : super(PDIInitial()) {
    on<UpdateInitialDetailsEvent>(_onUpdateInitialDetails);
    on<UpdateVehicleDetailsEvent>(_onUpdateVehicleDetails);
    on<UpdateBodyInspectionEvent>(_onUpdateBodyInspection);
    on<UpdateWheelsInspectionEvent>(_onUpdateWheelsInspection);
    on<SubmitPDIEvent>(_onSubmitPDI);
  }

  PDIData _currentData = const PDIData();

  // ----------------- Handlers -----------------
  void _onUpdateInitialDetails(
    UpdateInitialDetailsEvent event,
    Emitter<PDIState> emit,
  ) {
    _currentData = _currentData.copyWith(
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
      tyreFrtRhRemark: event.tyreFrtRhRemark,
      tyreFrtLh: event.tyreFrtLh,
      tyreFrtLhRemark: event.tyreFrtLhRemark,
      tyreRrRh: event.tyreRrRh,
      tyreRrRhRemark: event.tyreRrRhRemark,
      tyreRrLh: event.tyreRrLh,
      tyreRrLhRemark: event.tyreRrLhRemark,
      spareWheel: event.spareWheel,
      spareWheelRemark: event.spareWheelRemark,
    );
    emit(PDIUpdated(_currentData));
  }

  void _onUpdateBodyInspection(
    UpdateBodyInspectionEvent event,
    Emitter<PDIState> emit,
  ) {
    _currentData = _currentData.copyWith(
      bodyPaintCondition: event.bodyPaintCondition,
      bodyPaintRemark: event.bodyPaintRemark,
      dentsDefects: event.dentsDefects,
      dentsDefectsRemark: event.dentsDefectsRemark,
      doorsAlignment: event.doorsAlignment,
      doorsAlignmentRemark: event.doorsAlignmentRemark,
      doorsNoise: event.doorsNoise,
      doorsNoiseRemark: event.doorsNoiseRemark,
      tailGateNoise: event.tailGateNoise,
      tailGateNoiseRemark: event.tailGateNoiseRemark,
      remoteOperation: event.remoteOperation,
      remoteOperationRemark: event.remoteOperationRemark,
    );
    emit(PDIUpdated(_currentData));
  }

  void _onUpdateWheelsInspection(
    UpdateWheelsInspectionEvent event,
    Emitter<PDIState> emit,
  ) {
    _currentData = _currentData.copyWith(
      tyrePressure: event.tyrePressure,
      tyrePressureRemark: event.tyrePressureRemark,
      tyreFitment: event.tyreFitment,
      tyreFitmentRemark: event.tyreFitmentRemark,
      spareWheelUnlocking: event.spareWheelUnlocking,
      spareWheelUnlockingRemark: event.spareWheelUnlockingRemark,
      toolsAvailability: event.toolsAvailability,
      toolsAvailabilityRemark: event.toolsAvailabilityRemark,
      tailGateOperation: event.tailGateOperation,
      tailGateOperationRemark: event.tailGateOperationRemark,
      hsrpAvailability: event.hsrpAvailability,
      hsrpAvailabilityRemark: event.hsrpAvailabilityRemark,
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
        emit(PDiFailureState(
          message: "Failed to create PDI. User not found. Please login again.",
        ));
        return;
      }

      final pdiModel = PDIModel(
        vehicleType: event.vehicle,
        brand: event.brand,
        modelName: event.modelName,
        modelVariant: event.modelVariant,
        chassisNo: _currentData.chassisNo,
        engineNo: _currentData.engineNo,
        keyNo: _currentData.keyNo,
        batteryMake: _currentData.batteryMake,
        batterySerialNo: _currentData.batterySerialNo,
        dateOfReceipt: _currentData.dateOfReceipt,
        pdiKms: _currentData.pdiKms,
        bodyShade: _currentData.bodyShade,
        dateOfInspection: _currentData.dateOfInspection,
        tyreFrtRh: _currentData.tyreFrtRh ?? false,
        tyreFrtRhRemark: _currentData.tyreFrtRhRemark,
        tyreFrtLh: _currentData.tyreFrtLh ?? false,
        tyreFrtLhRemark: _currentData.tyreFrtLhRemark,
        tyreRrRh: _currentData.tyreRrRh ?? false,
        tyreRrRhRemark: _currentData.tyreRrRhRemark,
        tyreRrLh: _currentData.tyreRrLh ?? false,
        tyreRrLhRemark: _currentData.tyreRrLhRemark,
        spareWheel: _currentData.spareWheel ?? false,
        spareWheelRemark: _currentData.spareWheelRemark,

        bodyPaintCondition: _currentData.bodyPaintCondition ?? false,
        bodyPaintRemark: _currentData.bodyPaintRemark,
        dentsDefects: _currentData.dentsDefects ?? false,
        dentsDefectsRemark: _currentData.dentsDefectsRemark,
        doorsAlignment: _currentData.doorsAlignment ?? false,
        doorsAlignmentRemark: _currentData.doorsAlignmentRemark,
        doorsNoise: _currentData.doorsNoise ?? false,
        doorsNoiseRemark: _currentData.doorsNoiseRemark,
        tailGateNoise: _currentData.tailGateNoise ?? false,
        tailGateNoiseRemark: _currentData.tailGateNoiseRemark,
        remoteOperation: _currentData.remoteOperation ?? false,
        remoteOperationRemark: _currentData.remoteOperationRemark,
        // Wheels
        tyrePressure: _currentData.tyrePressure ?? false,
        tyrePressureRemark: _currentData.tyrePressureRemark,
        tyreFitment: _currentData.tyreFitment ?? false,
        tyreFitmentRemark: _currentData.tyreFitmentRemark,
        spareWheelUnlocking: _currentData.spareWheelUnlocking ?? false,
        spareWheelUnlockingRemark: _currentData.spareWheelUnlockingRemark,
        toolsAvailability: _currentData.toolsAvailability ?? false,
        toolsAvailabilityRemark: _currentData.toolsAvailabilityRemark,
        tailGateOperation: _currentData.tailGateOperation ?? false,
        tailGateOperationRemark: _currentData.tailGateOperationRemark,
        hsrpAvailability: _currentData.hsrpAvailability ?? false,
        hsrpAvailabilityRemark: _currentData.hsrpAvailabilityRemark,
        uid: uid,
        status: 'pending',
      );

      final success = await createPDIUseCase.execute(pdi: pdiModel);

      if (success) {
        emit(PDiSuccessState());
      } else {
        emit(PDiFailureState(message: "Failed to create PDI. Please try again."));
      }
    } catch (e) {
      emit(PDiFailureState(message: e.toString()));
    }
  }

  PDIData get currentData => _currentData;
}

