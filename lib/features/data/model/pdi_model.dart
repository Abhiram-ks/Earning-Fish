import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earningfish/features/domain/entity/pdi_entity.dart';

class PDIModel extends PDIEntity {
  final Timestamp createdAt;
  final String status;
  final String uid;
  final String? docId;

  PDIModel({
    super.modelName,
    super.modelVariant,
    super.chassisNo,
    super.engineNo,
    super.keyNo,
    super.batteryMake,
    super.batterySerialNo,
    super.dateOfReceipt,
    super.pdiKms,
    super.bodyShade,
    super.dateOfInspection,
    super.tyreFrtRh,
    super.tyreFrtLh,
    super.tyreRrRh,
    super.tyreRrLh,
    super.spareWheel,
    super.bodyPaintCondition,
    super.dentsDefects,
    super.doorsAlignment,
    super.doorsNoise,
    super.tailGateNoise,
    super.remoteOperation,
    super.tyrePressure,
    super.tyreFitment,
    super.spareWheelUnlocking,
    super.toolsAvailability,
    super.tailGateOperation,
    super.hsrpAvailability,
    Timestamp? createdAt,
    this.status = 'pending',
    this.uid = '',
    this.docId,
  }) : createdAt = createdAt ?? Timestamp.now();

  factory PDIModel.fromJson(Map<String, dynamic> json, String docId) {
    return PDIModel(
      docId: docId,
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
      tyreFrtRh: json['tyreFrtRh'],
      tyreFrtLh: json['tyreFrtLh'],
      tyreRrRh: json['tyreRrRh'],
      tyreRrLh: json['tyreRrLh'],
      spareWheel: json['spareWheel'],
      bodyPaintCondition: json['bodyPaintCondition'],
      dentsDefects: json['dentsDefects'],
      doorsAlignment: json['doorsAlignment'],
      doorsNoise: json['doorsNoise'],
      tailGateNoise: json['tailGateNoise'],
      remoteOperation: json['remoteOperation'],
      tyrePressure: json['tyrePressure'],
      tyreFitment: json['tyreFitment'],
      spareWheelUnlocking: json['spareWheelUnlocking'],
      toolsAvailability: json['toolsAvailability'],
      tailGateOperation: json['tailGateOperation'],
      hsrpAvailability: json['hsrpAvailability'],
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp)
          : Timestamp.now(),
      status: json['status'] ?? 'Pending',
      uid: json['uid'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'tyreFrtLh': tyreFrtLh,
      'tyreRrRh': tyreRrRh,
      'tyreRrLh': tyreRrLh,
      'spareWheel': spareWheel,
      'bodyPaintCondition': bodyPaintCondition,
      'dentsDefects': dentsDefects,
      'doorsAlignment': doorsAlignment,
      'doorsNoise': doorsNoise,
      'tailGateNoise': tailGateNoise,
      'remoteOperation': remoteOperation,
      'tyrePressure': tyrePressure,
      'tyreFitment': tyreFitment,
      'spareWheelUnlocking': spareWheelUnlocking,
      'toolsAvailability': toolsAvailability,
      'tailGateOperation': tailGateOperation,
      'hsrpAvailability': hsrpAvailability,
      'createdAt': createdAt, 
      'status': status,
      'uid': uid,
    };
  }
}
