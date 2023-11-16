import '../dto/sign_up_response.dart';

abstract class ISignUpRepository {
  Future<SignUpResponse> signup(Map<String, dynamic> body);
}
