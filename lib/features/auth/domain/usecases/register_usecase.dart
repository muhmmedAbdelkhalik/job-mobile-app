import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<AuthResponse> call(String name, String email, String password, String passwordConfirmation) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty) {
      throw Exception('All fields are required');
    }

    if (!_isValidEmail(email)) {
      throw Exception('Please enter a valid email address');
    }

    if (password.length < 8) {
      throw Exception('Password must be at least 8 characters long');
    }

    if (password != passwordConfirmation) {
      throw Exception('Passwords do not match');
    }

    return await _repository.register(name, email, password, passwordConfirmation);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
