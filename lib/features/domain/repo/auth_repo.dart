abstract class AuthRepository {
  Future<bool> loginWithEmailPassword({
    required String email,
    required String password,
  });
}