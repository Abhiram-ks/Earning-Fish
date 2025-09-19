import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/pdi_model.dart';

class FechPDIFirebaseDatasource {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<PDIModel>> fetch({required String uid}) {
    try {
       return firestore
        .collection('pdi')
        .where('uid', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) => PDIModel.fromJson(doc.data(), doc.id)).toList(),
        );
    } on FirebaseException catch (e) {
      log('Exeption occured firebasexeption: $e');
      throw Exception("Firestore Error: $e. Please try again");
    } catch (e) {
      throw Exception("Unexpected Error: $e. Please try again");
    }
  }
}
