import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:earningfish/features/domain/repo/pdi_repo.dart';

class CreatePDIUseCase {
  final PDIRepository repository;

  CreatePDIUseCase(this.repository);

  Future<bool> execute({required PDIModel pdi}) async {
   return await repository.createPDI(pdi: pdi);
  }
}