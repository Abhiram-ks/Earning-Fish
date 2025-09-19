part of 'pdi_bloc.dart';

@immutable
abstract class PDIEvent {
  const PDIEvent();
}

class UpdateInitialDetailsEvent extends PDIEvent {
  final String? modelName;
  final String? modelVariant;
  final String? chassisNo;
  final String? engineNo;
  final String? keyNo;
  final String? batteryMake;
  final String? batterySerialNo;
  final String? dateOfReceipt;
  final String? pdiKms;
  final String? bodyShade;

  const UpdateInitialDetailsEvent({
    this.modelName,
    this.modelVariant,
    this.chassisNo,
    this.engineNo,
    this.keyNo,
    this.batteryMake,
    this.batterySerialNo,
    this.dateOfReceipt,
    this.pdiKms,
    this.bodyShade,
  });
}

class UpdateVehicleDetailsEvent extends PDIEvent {
  final String? dateOfInspection;
  final bool? tyreFrtRh;
  final bool? tyreFrtLh;
  final bool? tyreRrRh;
  final bool? tyreRrLh;
  final bool? spareWheel;

  const UpdateVehicleDetailsEvent({
    this.dateOfInspection,
    this.tyreFrtRh,
    this.tyreFrtLh,
    this.tyreRrRh,
    this.tyreRrLh,
    this.spareWheel,
  });
}

class UpdateBodyInspectionEvent extends PDIEvent {
  final bool? bodyPaintCondition;
  final bool? dentsDefects;
  final bool? doorsAlignment;
  final bool? doorsNoise;
  final bool? tailGateNoise;
  final bool? remoteOperation;

  const UpdateBodyInspectionEvent({
    this.bodyPaintCondition,
    this.dentsDefects,
    this.doorsAlignment,
    this.doorsNoise,
    this.tailGateNoise,
    this.remoteOperation,
  });
}

class UpdateWheelsInspectionEvent extends PDIEvent {
  final bool? tyrePressure;
  final bool? tyreFitment;
  final bool? spareWheelUnlocking;
  final bool? toolsAvailability;
  final bool? tailGateOperation;
  final bool? hsrpAvailability;

  const UpdateWheelsInspectionEvent({
    this.tyrePressure,
    this.tyreFitment,
    this.spareWheelUnlocking,
    this.toolsAvailability,
    this.tailGateOperation,
    this.hsrpAvailability,
  });
}


class SubmitPDIEvent extends PDIEvent {
  const SubmitPDIEvent();
}