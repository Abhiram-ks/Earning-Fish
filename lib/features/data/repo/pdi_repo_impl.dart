import 'package:earningfish/features/data/datasource/pdi_remote_datasource.dart';
import 'package:earningfish/features/data/model/pdi_model.dart';
import 'package:earningfish/features/domain/repo/pdi_repo.dart';

class PdiRepositoryImpl implements PDIRepository {
  final PDIFirebaseDatasource datasource;
  PdiRepositoryImpl({required this.datasource});

  @override
  Future<bool> createPDI({
    required PDIModel pdi
  }) async {
    try {
      return await datasource.createPDI(pdi: pdi);
    } catch (e) {
      rethrow;
    }
  }
}