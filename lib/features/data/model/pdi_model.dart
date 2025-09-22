import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earningfish/features/domain/entity/pdi_entity.dart';

class PDIModel extends PDIEntity {
  final Timestamp createdAt;
  final String status;
  final String uid;
  final String? docId;

  PDIModel({
    Timestamp? createdAt,
    this.status = 'pending',
    this.uid = '',
    this.docId,
    
    required super.vehicleType,
    required super.brand,
    required super.modelName,
    required super.modelVariant,
    required super.chassisNo,
    required super.engineNo,
    required super.keyNo,
    required super.batteryMake,
    required super.batterySerialNo,
    required super.dateOfReceipt,
    required super.pdiKms,
    required super.bodyShade,
    required super.dateOfInspection,

    required super.tyreFrtRh,
    super.tyreFrtRhRemark,

    required super.tyreFrtLh,
    super.tyreFrtLhRemark,

    required super.tyreRrRh,
    super.tyreRrRhRemark,

    required super.tyreRrLh,
    super.tyreRrLhRemark,

    required super.spareWheel,
    super.spareWheelRemark,

    required super.bodyPaintCondition,
    super.bodyPaintRemark,

    required super.dentsDefects,
    super.dentsDefectsRemark,

    required super.doorsAlignment,
    super.doorsAlignmentRemark,

    required super.doorsNoise,
    super.doorsNoiseRemark,

    required super.tailGateNoise,
    super.tailGateNoiseRemark,

    required super.remoteOperation,
    super.remoteOperationRemark,

    required super.tyrePressure,
    super.tyrePressureRemark,

    required super.tyreFitment,
    super.tyreFitmentRemark,

    required super.spareWheelUnlocking,
    super.spareWheelUnlockingRemark,

    required super.toolsAvailability,
    super.toolsAvailabilityRemark,

    required super.tailGateOperation,
    super.tailGateOperationRemark,

    required super.hsrpAvailability,
    super.hsrpAvailabilityRemark,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory PDIModel.fromJson(Map<String, dynamic> json, String docId) {
    return PDIModel(
      vehicleType: json['vehicleType'] ?? '',
      brand: json['brand'] ?? '',
      modelName: json['modelName'] ?? '',
      modelVariant: json['modelVariant'] ?? '',
      chassisNo: json['chassisNo'] ?? '',
      engineNo: json['engineNo'] ?? '',
      keyNo: json['keyNo'] ?? '',
      batteryMake: json['batteryMake'] ?? '',
      batterySerialNo: json['batterySerialNo'] ?? '',
      dateOfReceipt: json['dateOfReceipt'] ?? '',
      pdiKms: json['pdiKms'] ?? '',
      bodyShade: json['bodyShade'] ?? '',
      dateOfInspection: json['dateOfInspection'] ?? '',

      tyreFrtRh: json['tyreFrtRh'] ?? false,
      tyreFrtRhRemark: json['tyreFrtRhRemark'],

      tyreFrtLh: json['tyreFrtLh'] ?? false,
      tyreFrtLhRemark: json['tyreFrtLhRemark'],

      tyreRrRh: json['tyreRrRh'] ?? false,
      tyreRrRhRemark: json['tyreRrRhRemark'],

      tyreRrLh: json['tyreRrLh'] ?? false,
      tyreRrLhRemark: json['tyreRrLhRemark'],

      spareWheel: json['spareWheel'] ?? false,
      spareWheelRemark: json['spareWheelRemark'],

      bodyPaintCondition: json['bodyPaintCondition'] ?? false,
      bodyPaintRemark: json['bodyPaintRemark'],

      dentsDefects: json['dentsDefects'] ?? false,
      dentsDefectsRemark: json['dentsDefectsRemark'],

      doorsAlignment: json['doorsAlignment'] ?? false,
      doorsAlignmentRemark: json['doorsAlignmentRemark'],

      doorsNoise: json['doorsNoise'] ?? false,
      doorsNoiseRemark: json['doorsNoiseRemark'],

      tailGateNoise: json['tailGateNoise'] ?? false,
      tailGateNoiseRemark: json['tailGateNoiseRemark'],

      remoteOperation: json['remoteOperation'] ?? false,
      remoteOperationRemark: json['remoteOperationRemark'],

      tyrePressure: json['tyrePressure'] ?? false,
      tyrePressureRemark: json['tyrePressureRemark'],

      tyreFitment: json['tyreFitment'] ?? false,
      tyreFitmentRemark: json['tyreFitmentRemark'],

      spareWheelUnlocking: json['spareWheelUnlocking'] ?? false,
      spareWheelUnlockingRemark: json['spareWheelUnlockingRemark'],

      toolsAvailability: json['toolsAvailability'] ?? false,
      toolsAvailabilityRemark: json['toolsAvailabilityRemark'],

      tailGateOperation: json['tailGateOperation'] ?? false,
      tailGateOperationRemark: json['tailGateOperationRemark'],

      hsrpAvailability: json['hsrpAvailability'] ?? false,
      hsrpAvailabilityRemark: json['hsrpAvailabilityRemark'],

      createdAt: json['createdAt'] ?? Timestamp.now(),
      status: json['status'] ?? 'pending',
      uid: json['uid'] ?? '',
      docId: docId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vehicleType': vehicleType,
      'brand': brand,
      'modelName': modelName,
      'modelVariant': modelVariant,
      'chassisNo': chassisNo,
      'engineNo': engineNo,
      'keyNo': keyNo,
      'batteryMake': batteryMake,
      'batterySerialNo': batterySerialNo,
      'dateOfReceipt': dateOfReceipt,
      'pdiKms': pdiKms,
      'bodyShade': bodyShade,
      'dateOfInspection': dateOfInspection,

      'tyreFrtRh': tyreFrtRh,
      'tyreFrtRhRemark': tyreFrtRhRemark,

      'tyreFrtLh': tyreFrtLh,
      'tyreFrtLhRemark': tyreFrtLhRemark,

      'tyreRrRh': tyreRrRh,
      'tyreRrRhRemark': tyreRrRhRemark,

      'tyreRrLh': tyreRrLh,
      'tyreRrLhRemark': tyreRrLhRemark,

      'spareWheel': spareWheel,
      'spareWheelRemark': spareWheelRemark,

      'bodyPaintCondition': bodyPaintCondition,
      'bodyPaintRemark': bodyPaintRemark,

      'dentsDefects': dentsDefects,
      'dentsDefectsRemark': dentsDefectsRemark,

      'doorsAlignment': doorsAlignment,
      'doorsAlignmentRemark': doorsAlignmentRemark,

      'doorsNoise': doorsNoise,
      'doorsNoiseRemark': doorsNoiseRemark,

      'tailGateNoise': tailGateNoise,
      'tailGateNoiseRemark': tailGateNoiseRemark,

      'remoteOperation': remoteOperation,
      'remoteOperationRemark': remoteOperationRemark,

      'tyrePressure': tyrePressure,
      'tyrePressureRemark': tyrePressureRemark,

      'tyreFitment': tyreFitment,
      'tyreFitmentRemark': tyreFitmentRemark,

      'spareWheelUnlocking': spareWheelUnlocking,
      'spareWheelUnlockingRemark': spareWheelUnlockingRemark,

      'toolsAvailability': toolsAvailability,
      'toolsAvailabilityRemark': toolsAvailabilityRemark,

      'tailGateOperation': tailGateOperation,
      'tailGateOperationRemark': tailGateOperationRemark,

      'hsrpAvailability': hsrpAvailability,
      'hsrpAvailabilityRemark': hsrpAvailabilityRemark,

      'createdAt': createdAt,
      'status': status,
      'uid': uid,
    };
  }
}
