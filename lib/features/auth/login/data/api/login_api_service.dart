import 'package:http/http.dart' as http;

import '../../../../../core/mixin/uri_mixin.dart';
import 'ilogin_api_service.dart';

class LoginApiService with UriMixin implements ILoginApiService {
  final http.Client client;
  LoginApiService(
   this.client,
  );

  @override
  Future<http.Response> login(Map<String, dynamic> body) async {
    try {
      final url = getUri('/api/v1/login');
      return await client.post(url, body: body);
    } catch (e) {
      rethrow;
    }
  }
}
