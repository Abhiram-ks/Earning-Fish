import 'package:earningfish/features/data/datasource/pdi_fech_remote_datasource.dart';
import 'package:earningfish/features/data/model/pdi_model.dart' show PDIModel;
import 'package:earningfish/features/domain/repo/pdi_fech_repo.dart';

class FetchPDIRepositoryImpl implements FechPDIRepository {
  final FechPDIFirebaseDatasource datasource;

  FetchPDIRepositoryImpl({required this.datasource}); 

  @override
  Stream<List<PDIModel>> getAllPDI({required String uid}) {
    try {
      return datasource.fetch(uid: uid);
    } catch (e) {
      rethrow;
    }
  }
}
