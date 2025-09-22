part of 'pdi_bloc.dart';

@immutable
abstract class PDIEvent {
  const PDIEvent();
}

class UpdateInitialDetailsEvent extends PDIEvent {
  final String? chassisNo;
  final String? engineNo;
  final String? keyNo;
  final String? batteryMake;
  final String? batterySerialNo;
  final String? dateOfReceipt;
  final String? pdiKms;
  final String? bodyShade;

  const UpdateInitialDetailsEvent({
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


// ----------------- Vehicle Details -----------------
class UpdateVehicleDetailsEvent extends PDIEvent {
  final String? dateOfInspection;
  final bool? tyreFrtRh;
  final String? tyreFrtRhRemark;
  final bool? tyreFrtLh;
  final String? tyreFrtLhRemark;
  final bool? tyreRrRh;
  final String? tyreRrRhRemark;
  final bool? tyreRrLh;
  final String? tyreRrLhRemark;
  final bool? spareWheel;
  final String? spareWheelRemark;

  const UpdateVehicleDetailsEvent({
    this.dateOfInspection,
    this.tyreFrtRh,
    this.tyreFrtRhRemark,
    this.tyreFrtLh,
    this.tyreFrtLhRemark,
    this.tyreRrRh,
    this.tyreRrRhRemark,
    this.tyreRrLh,
    this.tyreRrLhRemark,
    this.spareWheel,
    this.spareWheelRemark,
  });
}

// ----------------- Body Inspection -----------------
class UpdateBodyInspectionEvent extends PDIEvent {
  final bool? bodyPaintCondition;
  final String? bodyPaintRemark;
  final bool? dentsDefects;
  final String? dentsDefectsRemark;
  final bool? doorsAlignment;
  final String? doorsAlignmentRemark;
  final bool? doorsNoise;
  final String? doorsNoiseRemark;
  final bool? tailGateNoise;
  final String? tailGateNoiseRemark;
  final bool? remoteOperation;
  final String? remoteOperationRemark;

  const UpdateBodyInspectionEvent({
    this.bodyPaintCondition,
    this.bodyPaintRemark,
    this.dentsDefects,
    this.dentsDefectsRemark,
    this.doorsAlignment,
    this.doorsAlignmentRemark,
    this.doorsNoise,
    this.doorsNoiseRemark,
    this.tailGateNoise,
    this.tailGateNoiseRemark,
    this.remoteOperation,
    this.remoteOperationRemark,
  });
}

// ----------------- Wheels Inspection -----------------
class UpdateWheelsInspectionEvent extends PDIEvent {
  final bool? tyrePressure;
  final String? tyrePressureRemark;
  final bool? tyreFitment;
  final String? tyreFitmentRemark;
  final bool? spareWheelUnlocking;
  final String? spareWheelUnlockingRemark;
  final bool? toolsAvailability;
  final String? toolsAvailabilityRemark;
  final bool? tailGateOperation;
  final String? tailGateOperationRemark;
  final bool? hsrpAvailability;
  final String? hsrpAvailabilityRemark;

  const UpdateWheelsInspectionEvent({
    this.tyrePressure,
    this.tyrePressureRemark,
    this.tyreFitment,
    this.tyreFitmentRemark,
    this.spareWheelUnlocking,
    this.spareWheelUnlockingRemark,
    this.toolsAvailability,
    this.toolsAvailabilityRemark,
    this.tailGateOperation,
    this.tailGateOperationRemark,
    this.hsrpAvailability,
    this.hsrpAvailabilityRemark,
  });
}

class SubmitPDIEvent extends PDIEvent {
  final String vehicle;
  final String brand;
  final String modelName;
  final String modelVariant;
  
  const SubmitPDIEvent({required this.vehicle, required this.brand, required this.modelName, required this.modelVariant});
}