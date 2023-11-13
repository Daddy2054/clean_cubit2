import 'package:http/http.dart' as http;

import '../../../../../core/mixin/uri_mixin.dart';
import 'isign_up_api_service.dart';

class SignUpApiService with UriMixin implements ISignUpApiService {
  final http.Client client;

  SignUpApiService(this.client);

  @override
  Future<http.Response> signUp(Map<String, dynamic> body) async {
    try {
      final url = getUri('/api/v1/register');
      return await client.post(url, body: body);
    } catch (e) {
      rethrow;
    }
  }
}
