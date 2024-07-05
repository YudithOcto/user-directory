import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_directory/common/custom_text_field.dart';
import 'package:user_directory/common/custom_text_field_title.dart';
import 'package:user_directory/common/extensions.dart';
import 'package:user_directory/common/stringutils.dart';
import 'package:user_directory/di/di_container.dart';
import 'package:user_directory/ui/home/bloc/home_bloc.dart';
import 'package:user_directory/ui/home/home_screen.dart';
import 'package:user_directory/ui/login/bloc/login_bloc.dart';
import 'package:user_directory/ui/login/bloc/login_event.dart';
import 'package:user_directory/ui/login/bloc/login_state.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Form(
          key: _globalKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.isSuccess) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => BlocProvider(
                        create: (context) => locator<HomeBloc>(),
                        child: const HomeScreen(),
                      )),
                      (route) => true);
                }
              },
              builder: (blocContext, state) {
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _emailField(blocContext),
                        const SizedBox(height: 16),
                        _passwordField(blocContext, state.isObscure),
                        const SizedBox(height: 16),
                        _submitButton(blocContext, state.isSubmitting),
                      ],
                    ),
                    if (state.isSubmitting) ...{
                      const Center(child: CircularProgressIndicator()),
                    }
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return CustomTextFieldTitle(
        title: "Email",
        textFieldWidget: CustomTextField(
          textEditingController: _emailController,
          validator: (value) => value.isNotNullOrEmpty &&
                  StringUtils.isValidEmail(_emailController.text)
              ? null
              : "Email tidak valid",
          keyboardType: TextInputType.emailAddress,
        ));
  }

  Widget _passwordField(BuildContext context, bool isObscure) {
    return CustomTextFieldTitle(
        title: "Password",
        textFieldWidget: CustomTextField(
          textEditingController: _passwordController,
          keyboardType: TextInputType.visiblePassword,
          maxLines: 1,
          validator: (value) =>
              value.isNotNullOrEmpty ? null : "Password tidak valid",
          obscureText: isObscure,
          suffixIcon: InkWell(
              onTap: () {
                context
                    .read<LoginBloc>()
                    .add(const PasswordVisibilityChanged());
              },
              child: Icon(isObscure ? Icons.visibility_off : Icons.visibility)),
        ));
  }

  Widget _submitButton(BuildContext context, bool isStateSubmitting) {
    return ElevatedButton(
      onPressed: () {
        if (_globalKey.currentState!.validate()) {
          if (!isStateSubmitting) {
            context.read<LoginBloc>().add(LoginSubmitted(
                _emailController.text, _passwordController.text));
          }
        }
      },
      child: const Text('Submit'),
    );
  }

  Widget _registerText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the register screen
      },
      child: Text(
        'Register',
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).primaryColor),
      ),
    );
  }
}
