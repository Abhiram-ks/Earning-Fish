class PDIData {
  // Initial Details
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
  final String? tyreFrtRhRemark;
  final bool? tyreFrtLh;
  final String? tyreFrtLhRemark;
  final bool? tyreRrRh;
  final String? tyreRrRhRemark;
  final bool? tyreRrLh;
  final String? tyreRrLhRemark;
  final bool? spareWheel;
  final String? spareWheelRemark;

  // Body Outside Inspection
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

  // Wheels Tyres & Boot
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

  const PDIData({
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
    this.tyreFrtRhRemark,
    this.tyreFrtLh,
    this.tyreFrtLhRemark,
    this.tyreRrRh,
    this.tyreRrRhRemark,
    this.tyreRrLh,
    this.tyreRrLhRemark,
    this.spareWheel,
    this.spareWheelRemark,
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

  PDIData copyWith({
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
    String? tyreFrtRhRemark,
    bool? tyreFrtLh,
    String? tyreFrtLhRemark,
    bool? tyreRrRh,
    String? tyreRrRhRemark,
    bool? tyreRrLh,
    String? tyreRrLhRemark,
    bool? spareWheel,
    String? spareWheelRemark,
    bool? bodyPaintCondition,
    String? bodyPaintRemark,
    bool? dentsDefects,
    String? dentsDefectsRemark,
    bool? doorsAlignment,
    String? doorsAlignmentRemark,
    bool? doorsNoise,
    String? doorsNoiseRemark,
    bool? tailGateNoise,
    String? tailGateNoiseRemark,
    bool? remoteOperation,
    String? remoteOperationRemark,
    bool? tyrePressure,
    String? tyrePressureRemark,
    bool? tyreFitment,
    String? tyreFitmentRemark,
    bool? spareWheelUnlocking,
    String? spareWheelUnlockingRemark,
    bool? toolsAvailability,
    String? toolsAvailabilityRemark,
    bool? tailGateOperation,
    String? tailGateOperationRemark,
    bool? hsrpAvailability,
    String? hsrpAvailabilityRemark,
  }) {
    return PDIData(
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
      tyreFrtRhRemark: tyreFrtRhRemark ?? this.tyreFrtRhRemark,
      tyreFrtLh: tyreFrtLh ?? this.tyreFrtLh,
      tyreFrtLhRemark: tyreFrtLhRemark ?? this.tyreFrtLhRemark,
      tyreRrRh: tyreRrRh ?? this.tyreRrRh,
      tyreRrRhRemark: tyreRrRhRemark ?? this.tyreRrRhRemark,
      tyreRrLh: tyreRrLh ?? this.tyreRrLh,
      tyreRrLhRemark: tyreRrLhRemark ?? this.tyreRrLhRemark,
      spareWheel: spareWheel ?? this.spareWheel,
      spareWheelRemark: spareWheelRemark ?? this.spareWheelRemark,
      bodyPaintCondition: bodyPaintCondition ?? this.bodyPaintCondition,
      bodyPaintRemark: bodyPaintRemark ?? this.bodyPaintRemark,
      dentsDefects: dentsDefects ?? this.dentsDefects,
      dentsDefectsRemark: dentsDefectsRemark ?? this.dentsDefectsRemark,
      doorsAlignment: doorsAlignment ?? this.doorsAlignment,
      doorsAlignmentRemark: doorsAlignmentRemark ?? this.doorsAlignmentRemark,
      doorsNoise: doorsNoise ?? this.doorsNoise,
      doorsNoiseRemark: doorsNoiseRemark ?? this.doorsNoiseRemark,
      tailGateNoise: tailGateNoise ?? this.tailGateNoise,
      tailGateNoiseRemark: tailGateNoiseRemark ?? this.tailGateNoiseRemark,
      remoteOperation: remoteOperation ?? this.remoteOperation,
      remoteOperationRemark: remoteOperationRemark ?? this.remoteOperationRemark,
      tyrePressure: tyrePressure ?? this.tyrePressure,
      tyrePressureRemark: tyrePressureRemark ?? this.tyrePressureRemark,
      tyreFitment: tyreFitment ?? this.tyreFitment,
      tyreFitmentRemark: tyreFitmentRemark ?? this.tyreFitmentRemark,
      spareWheelUnlocking: spareWheelUnlocking ?? this.spareWheelUnlocking,
      spareWheelUnlockingRemark: spareWheelUnlockingRemark ?? this.spareWheelUnlockingRemark,
      toolsAvailability: toolsAvailability ?? this.toolsAvailability,
      toolsAvailabilityRemark: toolsAvailabilityRemark ?? this.toolsAvailabilityRemark,
      tailGateOperation: tailGateOperation ?? this.tailGateOperation,
      tailGateOperationRemark: tailGateOperationRemark ?? this.tailGateOperationRemark,
      hsrpAvailability: hsrpAvailability ?? this.hsrpAvailability,
      hsrpAvailabilityRemark: hsrpAvailabilityRemark ?? this.hsrpAvailabilityRemark,
    );
  }

  bool get isComplete {
    final textFieldsComplete =
        chassisNo.isNotEmpty &&
        engineNo.isNotEmpty &&
        keyNo.isNotEmpty &&
        batteryMake.isNotEmpty &&
        batterySerialNo.isNotEmpty &&
        dateOfReceipt.isNotEmpty &&
        pdiKms.isNotEmpty &&
        bodyShade.isNotEmpty &&
        dateOfInspection.isNotEmpty;

  
    bool checkField(bool? value, String? remark) {
      if (value == null) return false;
      if (value == false && (remark == null || remark.trim().isEmpty)) {
        return false;
      }
      return true;
    }

    final checklistComplete =
        checkField(tyreFrtRh, tyreFrtRhRemark) &&
        checkField(tyreFrtLh, tyreFrtLhRemark) &&
        checkField(tyreRrRh, tyreRrRhRemark) &&
        checkField(tyreRrLh, tyreRrLhRemark) &&
        checkField(spareWheel, spareWheelRemark) &&
        checkField(bodyPaintCondition, bodyPaintRemark) &&
        checkField(dentsDefects, dentsDefectsRemark) &&
        checkField(doorsAlignment, doorsAlignmentRemark) &&
        checkField(doorsNoise, doorsNoiseRemark) &&
        checkField(tailGateNoise, tailGateNoiseRemark) &&
        checkField(remoteOperation, remoteOperationRemark) &&
        checkField(tyrePressure, tyrePressureRemark) &&
        checkField(tyreFitment, tyreFitmentRemark) &&
        checkField(spareWheelUnlocking, spareWheelUnlockingRemark) &&
        checkField(toolsAvailability, toolsAvailabilityRemark) &&
        checkField(tailGateOperation, tailGateOperationRemark) &&
        checkField(hsrpAvailability, hsrpAvailabilityRemark);

    return textFieldsComplete && checklistComplete;
  }
}
