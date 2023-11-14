import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common/form/custom_text_form_field.dart';
import '../../../../../common/mixin/dialog_mixin.dart';
import '../../../../../common/style/dimens.dart';
import '../controller/sign_up_controller.dart';
import '../state/sign_up_state.dart';
import 'widget/sign_up_button.dart';
import 'widget/sign_up_checkbox.dart';
import 'widget/sign_up_password_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with DialogMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kMedium),
          child: Form(
            key: _formKey,
            child: BlocConsumer<SignUpController, SignUpState>(
              listenWhen: (previous, current) {
                return current.isSignUp != previous.isSignUp ||
                    current.errorMsg != previous.errorMsg;
              },
              listener: (context, state) {
                if (state.isSignUp) {
                  _showConfirmDialog();
                }
                if (state.errorMsg != null) {
                  _showSnackBar(state.errorMsg ?? 'Something went wrong');
                }
              },
              buildWhen: (previous, current) => false,
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(
                      height: kMedium,
                    ),
                    CustomTextFormField(
                      controller: _nameController,
                      labelText: 'Name',
                      hintText: 'Enter your name',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.account_circle),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'name is empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignUpController>().setFormData(
                              key: 'name',
                              value: value,
                            );
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: kMedium,
                    ),
                    CustomTextFormField(
                      controller: _emailController,
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'email is empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignUpController>().setFormData(
                              key: 'email',
                              value: value,
                            );
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: kMedium,
                    ),
                    SignUpPasswordWidget(
                      formKey: 'password',
                      passwordController: _passwordController,
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      validatorText: 'Password is empty',
                    ),
                    const SizedBox(
                      height: kMedium,
                    ),
                    SignUpPasswordWidget(
                      formKey: 'password_confirmation',
                      passwordController: _confirmPasswordController,
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      validatorText: 'Confirm password is empty',
                    ),
                    const SizedBox(
                      height: kMedium,
                    ),
                    CustomTextFormField(
                      controller: _phoneController,
                      labelText: 'Phone',
                      hintText: 'Enter your phone',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      prefixIcon: const Icon(Icons.phone),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'phone is empty';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        context.read<SignUpController>().setFormData(
                              key: 'phone ',
                              value: value,
                            );
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: kMedium,
                    ),
                    const SignUpCheckBox(),
                    const SizedBox(
                      height: kMedium,
                    ),
                    SignUpButton(onPressed: _signUp),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      context.read<SignUpController>().signUp();
    }
  }

  void _showSnackBar(String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMsg),
      ),
    );
  }

  void _showConfirmDialog() {
    showConfirmDialog(
      context: context,
      title: 'Do you want to login?',
      msg: 'You will be redirected to the login screen.',
      btnYesText: 'YES',
      btnNoText: 'NO',
      onYesTap: () {
        //dismiss the dialog
        final navigator = Navigator.of(context, rootNavigator: true);
        if (navigator.canPop()) {
          navigator.pop();
        }
        // navigate to login screen
        context.go('/login');
      },
      onNoTap: () {
        //dismiss the dialog
        final navigator = Navigator.of(context, rootNavigator: true);
        if (navigator.canPop()) {
          navigator.pop();
        }
      },
    );
  }
}
