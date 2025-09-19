import 'package:earningfish/features/domain/repo/auth_repo.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<bool> execute({required String email, required String password}) async {
    return await repository.loginWithEmailPassword(email: email, password: password);
  }
}
