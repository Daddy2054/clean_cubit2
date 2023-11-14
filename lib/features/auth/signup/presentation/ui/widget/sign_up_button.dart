import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widget/button/primary_button.dart';
import '../../controller/sign_up_controller.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  const SignUpButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<SignUpController>().state.isLoading;
    return PrimaryButton(
      text: 'SignUp',
      isEnabled: isLoading ? false : true,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
