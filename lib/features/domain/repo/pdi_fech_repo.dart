import '../../data/model/pdi_model.dart';

abstract class FechPDIRepository {
  Stream<List<PDIModel>> getAllPDI({required String uid});
}
