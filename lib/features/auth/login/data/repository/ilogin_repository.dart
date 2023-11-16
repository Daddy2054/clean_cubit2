
import '../dto/login_response.dart';

abstract class ILoginRepository {
  Future<LoginResponse> login(Map<String, dynamic> body);
}
