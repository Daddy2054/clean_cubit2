import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widget/button/primary_button.dart';
import '../../controller/login_controller.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LoginButton({super.key,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<LoginController>().state.isLoading;
    return PrimaryButton(
      text: 'Login',
      isEnabled: isLoading ? false : true,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
