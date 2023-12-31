import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/exception/failure.dart';
import '../../application/isign_up_service.dart';
import '../state/sign_up_state.dart';

class SignUpController extends Cubit<SignUpState> {
  final ISignUpService _signUpService;
  SignUpController(
    super.initialState,
    this._signUpService,
  );

  void signUp() async {
    try {
      emit(state.copyWith(
        isLoading: true,
        errorMsg: null,
      ));

      final result = await _signUpService.signUp(state.formData);
      emit(
        state.copyWith(
          isLoading: false,
          isSignUp: result,
        ),
      );
    } on Failure catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMsg: e.message,
//          errorMsg: e.toString(),
        ),
      );
    }
  }

  void setTermsAndConditions(
    bool value,
  ) {
    emit(state.copyWith(
      isTermsAndConditions: value,
    ));
  }

  void isObscure() {
    emit(state.copyWith(
      isObscure: !state.isObscure,
    ));
  }

  void setFormData({
    required String key,
    required dynamic value,
  }) {
    emit(
      state.copyWith(
        formData: {
          ...state.formData,
          ...{key: value}
        },
      ),
    );
  }
}
