class PDIEntity {
  final String vehicleType;
  final String brand;
  final String modelName;
  final String modelVariant;
  final String chassisNo;
  final String engineNo;
  final String keyNo;
  final String batteryMake;
  final String batterySerialNo;
  final String dateOfReceipt;
  final String pdiKms;
  final String bodyShade;
  final String dateOfInspection;

  final bool tyreFrtRh;
  final String? tyreFrtRhRemark;

  final bool tyreFrtLh;
  final String? tyreFrtLhRemark;

  final bool tyreRrRh;
  final String? tyreRrRhRemark;

  final bool tyreRrLh;
  final String? tyreRrLhRemark;

  final bool spareWheel;
  final String? spareWheelRemark;

  final bool bodyPaintCondition;
  final String? bodyPaintRemark;

  final bool dentsDefects;
  final String? dentsDefectsRemark;

  final bool doorsAlignment;
  final String? doorsAlignmentRemark;

  final bool doorsNoise;
  final String? doorsNoiseRemark;

  final bool tailGateNoise;
  final String? tailGateNoiseRemark;

  final bool remoteOperation;
  final String? remoteOperationRemark;

  final bool tyrePressure;
  final String? tyrePressureRemark;

  final bool tyreFitment;
  final String? tyreFitmentRemark;

  final bool spareWheelUnlocking;
  final String? spareWheelUnlockingRemark;

  final bool toolsAvailability;
  final String? toolsAvailabilityRemark;

  final bool tailGateOperation;
  final String? tailGateOperationRemark;

  final bool hsrpAvailability;
  final String? hsrpAvailabilityRemark;

  const PDIEntity({
    required this.vehicleType,
    required this.brand,
    required this.modelName,
    required this.modelVariant,
    required this.chassisNo,
    required this.engineNo,
    required this.keyNo,
    required this.batteryMake,
    required this.batterySerialNo,
    required this.dateOfReceipt,
    required this.pdiKms,
    required this.bodyShade,
    required this.dateOfInspection,

    required this.tyreFrtRh,
    this.tyreFrtRhRemark,

    required this.tyreFrtLh,
    this.tyreFrtLhRemark,

    required this.tyreRrRh,
    this.tyreRrRhRemark,

    required this.tyreRrLh,
    this.tyreRrLhRemark,

    required this.spareWheel,
    this.spareWheelRemark,

    required this.bodyPaintCondition,
    this.bodyPaintRemark,

    required this.dentsDefects,
    this.dentsDefectsRemark,

    required this.doorsAlignment,
    this.doorsAlignmentRemark,

    required this.doorsNoise,
    this.doorsNoiseRemark,

    required this.tailGateNoise,
    this.tailGateNoiseRemark,

    required this.remoteOperation,
    this.remoteOperationRemark,

    required this.tyrePressure,
    this.tyrePressureRemark,

    required this.tyreFitment,
    this.tyreFitmentRemark,

    required this.spareWheelUnlocking,
    this.spareWheelUnlockingRemark,

    required this.toolsAvailability,
    this.toolsAvailabilityRemark,

    required this.tailGateOperation,
    this.tailGateOperationRemark,

    required this.hsrpAvailability,
    this.hsrpAvailabilityRemark,
  });
}
