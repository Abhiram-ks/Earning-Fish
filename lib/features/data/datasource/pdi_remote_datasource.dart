import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earningfish/features/data/model/pdi_model.dart';

class PDIFirebaseDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> createPDI({required PDIModel pdi}) async {
    try {
      final docRef = firestore.collection('pdi').doc();
      await docRef.set({'docId': docRef.id, ...pdi.toJson()});
      return true;
    } on FirebaseException catch (e) {
      log('Exeption occured firebasexeption: $e');
      throw Exception("Firestore Error: $e. Please try again");
    } catch (e) {
      log('Exeption occured unexpectd: $e');
      throw Exception("Unexpected Error: $e. Please try again");
    }
  }
}
