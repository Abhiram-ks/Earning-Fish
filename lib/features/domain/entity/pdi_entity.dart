class PDIEntity {
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
  final bool? tyreFrtRh;
  final bool? tyreFrtLh;
  final bool? tyreRrRh;
  final bool? tyreRrLh;
  final bool? spareWheel;

  final bool? bodyPaintCondition;
  final bool? dentsDefects;
  final bool? doorsAlignment;
  final bool? doorsNoise;
  final bool? tailGateNoise;
  final bool? remoteOperation;

  final bool? tyrePressure;
  final bool? tyreFitment;
  final bool? spareWheelUnlocking;
  final bool? toolsAvailability;
  final bool? tailGateOperation;
  final bool? hsrpAvailability;

  const PDIEntity({
    this.modelName = '',
    this.modelVariant = '',
    this.chassisNo = '',
    this.engineNo = '',
    this.keyNo = '',
    this.batteryMake = '',
    this.batterySerialNo = '',
    this.dateOfReceipt = '',
    this.pdiKms = '',
    this.bodyShade = '',
    this.dateOfInspection = '',
    this.tyreFrtRh,
    this.tyreFrtLh,
    this.tyreRrRh,
    this.tyreRrLh,
    this.spareWheel,
    this.bodyPaintCondition,
    this.dentsDefects,
    this.doorsAlignment,
    this.doorsNoise,
    this.tailGateNoise,
    this.remoteOperation,
    this.tyrePressure,
    this.tyreFitment,
    this.spareWheelUnlocking,
    this.toolsAvailability,
    this.tailGateOperation,
    this.hsrpAvailability,
  });

  bool get isComplete {
    final textFieldsComplete =
        modelName.isNotEmpty &&
        modelVariant.isNotEmpty &&
        chassisNo.isNotEmpty &&
        engineNo.isNotEmpty &&
        keyNo.isNotEmpty &&
        batteryMake.isNotEmpty &&
        batterySerialNo.isNotEmpty &&
        dateOfReceipt.isNotEmpty &&
        pdiKms.isNotEmpty &&
        bodyShade.isNotEmpty &&
        dateOfInspection.isNotEmpty;

    final checklistComplete =
        tyreFrtRh != null &&
        tyreFrtLh != null &&
        tyreRrRh != null &&
        tyreRrLh != null &&
        spareWheel != null &&
        bodyPaintCondition != null &&
        dentsDefects != null &&
        doorsAlignment != null &&
        doorsNoise != null &&
        tailGateNoise != null &&
        remoteOperation != null &&
        tyrePressure != null &&
        tyreFitment != null &&
        spareWheelUnlocking != null &&
        toolsAvailability != null &&
        tailGateOperation != null &&
        hsrpAvailability != null;

    return textFieldsComplete && checklistComplete;
  }
}
