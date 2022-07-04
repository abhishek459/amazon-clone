import 'package:flutter/material.dart';

import '../../common/widgets/custom_button.dart';
import '../../common/widgets/custom_textfield.dart';
import '../../constants/global_variables.dart';
import '../services/auth_service.dart';
import '../widgets/login_options.dart';

enum Auth {
  signup,
  signin,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  void _signUpUser() {
    FocusScope.of(context).unfocus();
    if (_signUpFormKey.currentState!.validate()) {
      authService.signUpUser(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    }
  }

  void _signInUser() {
    FocusScope.of(context).unfocus();
    if (_signInFormKey.currentState!.validate()) {
      authService.signInUser(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              LoginOptions(
                value: Auth.signup,
                groupValue: _auth,
                label: 'Create Account',
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          textEditingController: _nameController,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          textEditingController: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          textEditingController: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(label: 'Sign Up', onPressed: _signUpUser),
                      ],
                    ),
                  ),
                ),
              LoginOptions(
                value: Auth.signin,
                groupValue: _auth,
                label: 'Sign In',
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        CustomTextField(
                          textEditingController: _emailController,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          textEditingController: _passwordController,
                          hintText: 'Password',
                        ),
                        const SizedBox(height: 10),
                        CustomButton(label: 'Sign In', onPressed: _signInUser),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
