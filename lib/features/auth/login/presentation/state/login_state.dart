import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) final bool isLoading,
    @Default(false) final bool isLoggedIn,
    @Default(false) final bool isObscure,
    @Default({}) final Map<String, dynamic> formData,
    final String? errorMsg,
  }) = _LoginState;
}
