import '../../data/model/pdi_model.dart';

abstract class FechPDIRepository {
  Stream<List<PDIModel>> getAllPDI({required String uid});
  Stream<List<PDIModel>> getQuaryPDI({required String uid,required String quary});
}
