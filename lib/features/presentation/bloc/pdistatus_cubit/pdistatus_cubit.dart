import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'pdistatus_state.dart';

class PDIStatusCubit extends Cubit<PDIStatusState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  PDIStatusCubit() : super(PDIStatusInitial());

  Future<void> updateStatus({
    required String pdiId,
    required String newStatus,
  }) async {

    try {
      final docRef = firestore.collection('pdi').doc(pdiId);
      await docRef.update({'status': newStatus});
      emit(PDIStatusSuccess());
    } on FirebaseException catch (e) {
      emit(PDIStatusFailure(message: "Firestore error: $e"));
    } catch (e) {
      emit(PDIStatusFailure(message: "Unexpected error: $e"));
    }
  }
}