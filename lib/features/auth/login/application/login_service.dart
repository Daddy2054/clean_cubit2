import '../../../../core/exception/failure.dart';
import '../data/repository/ilogin_repository.dart';
import 'ilogin_service.dart';

class LoginService implements ILoginService {
  final ILoginRepository _loginRepository;

  LoginService(this._loginRepository);

  @override
  Future<bool> login(Map<String, dynamic> body) async {
    try {
      final response = await _loginRepository.login(body);
      return response.accessToken.isNotEmpty ? true : false;
    } on Failure catch (_) {
      rethrow;
    }
  }
}
