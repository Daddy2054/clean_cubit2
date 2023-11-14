import '../../../../core/exception/failure.dart';
import '../data/repository/isign_up_repository.dart';
import 'isign_up_service.dart';

class SignUpService implements ISignUpService {
  final ISignUpRepository _signUpRepository;

  SignUpService(this._signUpRepository);

  @override
  Future<bool> signUp(Map<String, dynamic> body) async {
    try {
      final result = await _signUpRepository.signup(body);
      return result.id >= 1 ? true : false;
    } on Failure catch (_) {
      rethrow;
    }
  }
}
