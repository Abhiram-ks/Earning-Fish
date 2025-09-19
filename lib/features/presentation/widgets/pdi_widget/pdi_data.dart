
class PDIData {
  // Initial Details
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

  // Vehicle Details
  final String dateOfInspection;
  final bool? tyreFrtRh;
  final bool? tyreFrtLh;
  final bool? tyreRrRh;
  final bool? tyreRrLh;
  final bool? spareWheel;

  // Body Outside Inspection
  final bool? bodyPaintCondition;
  final bool? dentsDefects;
  final bool? doorsAlignment;
  final bool? doorsNoise;
  final bool? tailGateNoise;
  final bool? remoteOperation;

  // Wheels Tyres & Boot
  final bool? tyrePressure;
  final bool? tyreFitment;
  final bool? spareWheelUnlocking;
  final bool? toolsAvailability;
  final bool? tailGateOperation;
  final bool? hsrpAvailability;

  const PDIData({
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

  PDIData copyWith({
    String? modelName,
    String? modelVariant,
    String? chassisNo,
    String? engineNo,
    String? keyNo,
    String? batteryMake,
    String? batterySerialNo,
    String? dateOfReceipt,
    String? pdiKms,
    String? bodyShade,
    String? dateOfInspection,
    bool? tyreFrtRh,
    bool? tyreFrtLh,
    bool? tyreRrRh,
    bool? tyreRrLh,
    bool? spareWheel,
    bool? bodyPaintCondition,
    bool? dentsDefects,
    bool? doorsAlignment,
    bool? doorsNoise,
    bool? tailGateNoise,
    bool? remoteOperation,
    bool? tyrePressure,
    bool? tyreFitment,
    bool? spareWheelUnlocking,
    bool? toolsAvailability,
    bool? tailGateOperation,
    bool? hsrpAvailability,
  }) {
    return PDIData(
      modelName: modelName ?? this.modelName,
      modelVariant: modelVariant ?? this.modelVariant,
      chassisNo: chassisNo ?? this.chassisNo,
      engineNo: engineNo ?? this.engineNo,
      keyNo: keyNo ?? this.keyNo,
      batteryMake: batteryMake ?? this.batteryMake,
      batterySerialNo: batterySerialNo ?? this.batterySerialNo,
      dateOfReceipt: dateOfReceipt ?? this.dateOfReceipt,
      pdiKms: pdiKms ?? this.pdiKms,
      bodyShade: bodyShade ?? this.bodyShade,
      dateOfInspection: dateOfInspection ?? this.dateOfInspection,
      tyreFrtRh: tyreFrtRh ?? this.tyreFrtRh,
      tyreFrtLh: tyreFrtLh ?? this.tyreFrtLh,
      tyreRrRh: tyreRrRh ?? this.tyreRrRh,
      tyreRrLh: tyreRrLh ?? this.tyreRrLh,
      spareWheel: spareWheel ?? this.spareWheel,
      bodyPaintCondition: bodyPaintCondition ?? this.bodyPaintCondition,
      dentsDefects: dentsDefects ?? this.dentsDefects,
      doorsAlignment: doorsAlignment ?? this.doorsAlignment,
      doorsNoise: doorsNoise ?? this.doorsNoise,
      tailGateNoise: tailGateNoise ?? this.tailGateNoise,
      remoteOperation: remoteOperation ?? this.remoteOperation,
      tyrePressure: tyrePressure ?? this.tyrePressure,
      tyreFitment: tyreFitment ?? this.tyreFitment,
      spareWheelUnlocking: spareWheelUnlocking ?? this.spareWheelUnlocking,
      toolsAvailability: toolsAvailability ?? this.toolsAvailability,
      tailGateOperation: tailGateOperation ?? this.tailGateOperation,
      hsrpAvailability: hsrpAvailability ?? this.hsrpAvailability,
    );
  }

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