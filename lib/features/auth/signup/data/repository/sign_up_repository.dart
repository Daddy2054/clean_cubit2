import 'dart:io';

import '../../../../../core/exception/failure.dart';
import '../../../../../core/extension/http_response_error.dart';
import '../api/isign_up_api_service.dart';
import '../dto/sign_up_response.dart';
import 'isign_up_repository.dart';

class SignUpRepository implements ISignUpRepository {
  final ISignUpApiService _iSignUpApiService;

  SignUpRepository(this._iSignUpApiService);

  @override
  Future<SignUpResponse> signup(Map<String, dynamic> body) async {
    try {
      final response = await _iSignUpApiService.signUp(body);
      if (response.statusCode != HttpStatus.created) {
        throw Failure(message: response.httpResponseError());
      }
      return signUpResponseFromJson(response.body);
    } catch (e) {
      throw Failure(message: e.toString());
    }
  }
}
