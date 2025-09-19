import 'package:earningfish/features/data/datasource/auth_local_datasource.dart';
import 'package:earningfish/features/data/datasource/auth_remote_datasource.dart';
import 'package:earningfish/features/domain/repo/auth_repo.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthRemoteDatasource remoteDS;
  final AuthLocalDatasource localDS;

  AuthRepositoryImpl({
    required this.remoteDS,
    required this.localDS,
  });

  @override
  Future<bool> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final uid = await remoteDS.loginWithEmailPassword(
        email: email,
        password: password,
      ); 
      return await localDS.save(uid!);
    } catch (e) {
      rethrow;
    }
  }
}