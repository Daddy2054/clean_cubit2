import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/form/custom_text_form_field.dart';
import '../../../../../common/style/dimens.dart';
import '../controller/login_controller.dart';
import 'widget/login_button.dart';
import 'widget/login_password_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                  context.read<LoginController>().setFormData(
                        key: 'email',
                        value: value,
                      );
                  return null;
                },
              ),
              const SizedBox(
                height: kMedium,
              ),
              LoginPasswordWidget(
                formKey: 'password',
                passwordController: _passwordController,
                labelText: 'Password',
                hintText: 'Enter your password',
                validatorText: 'Password is empty',
              ),
              const SizedBox(
                height: kMedium,
              ),
              LoginButton(
                onPressed: _login,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() {
    final isValid = _formKey.currentState?.validate();
    if (isValid != null && isValid) {
      context.read<LoginController>().login();
    }
  }
}
