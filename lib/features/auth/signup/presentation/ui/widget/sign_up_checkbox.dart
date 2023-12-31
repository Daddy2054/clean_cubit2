import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widget/check_box_widget.dart';
import '../../controller/sign_up_controller.dart';

class SignUpCheckBox extends StatelessWidget {
  const SignUpCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isTermsAndConditions =
        context.watch<SignUpController>().state.isTermsAndConditions;
    return CheckboxWidget(
        title: 'Terms and conditions',
        subtitle: 'Please accept the terms and conditions',
        value: isTermsAndConditions,
        validator: (value) {
//          if (!isTermsAndConditions) {
          if (value != null && !value) {
            return 'Please accept the terms and conditions';
          }
          return null;
        },
        onChanged: (value) {
          context.read<SignUpController>().setTermsAndConditions(
                value ?? false,
              );
        });
  }
}
