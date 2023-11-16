//import 'package:http/http.dart' as http;
import 'package:http/src/response.dart';

abstract class ILoginApiService {
  Future<Response> login(Map<String, dynamic> body);
}
