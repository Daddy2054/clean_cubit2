import 'dart:io';

import '../../../../../core/extension/http_response_error.dart';
import '../../../../../core/exception/failure.dart';
import '../api/ilogin_api_service.dart';
import '../dto/login_response.dart';
import 'ilogin_repository.dart';

class LoginRepository implements ILoginRepository {
  final ILoginApiService _loginApiService;

  LoginRepository(this._loginApiService);

  @override
  Future<LoginResponse> login(Map<String, dynamic> body) async {
    try {
      final response = await _loginApiService.login(body);

      if (response.statusCode != HttpStatus.ok) {
        throw Failure(message: response.httpResponseError());
      }
      return loginResponseFromJson(response.body);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
