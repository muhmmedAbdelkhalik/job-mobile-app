import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<AuthResponse> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and password are required');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Please enter a valid email address');
    }

    return await _repository.login(email, password);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
