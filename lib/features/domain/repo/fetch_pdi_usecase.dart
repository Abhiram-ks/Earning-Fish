import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:earningfish/features/domain/repo/pdi_fech_repo.dart';

class FetchPDIUseCase {
  final FechPDIRepository repository;

  FetchPDIUseCase(this.repository);

  Stream<List<PDIModel>> execute({required String uid}) {
    return repository.getAllPDI(uid: uid);
  }
}