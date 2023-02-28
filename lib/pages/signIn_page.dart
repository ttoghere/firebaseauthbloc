import 'dart:developer';
import 'package:firebaseauthbloc/cubits/signIn/sign_in_cubit.dart';
import 'package:firebaseauthbloc/pages/signUp_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../utils/error_dialog.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/signin";
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  String? _email;

  String? _password;

  void _submit() {
    setState(() {
      _autoValidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    log("Email: $_email, Password: $_password");
    context.read<SignInCubit>().signIn(email: _email!, password: _password!);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<SignInCubit, SignInState>(
          listener: (context, state) {
            if (state.signInStatus == SignInStatus.error) {
              errorDialog(context, state.customError);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autoValidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Image.asset(
                          "assets/images/flutter_logo.png",
                          width: 250,
                          height: 250,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Email Required";
                            }
                            if (!isEmail(value.trim())) {
                              return "Enter a valid Email";
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _email = value!;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password required';
                            }
                            if (value.trim().length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _password = value;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed:
                              state.signInStatus == SignInStatus.submiting
                                  ? null
                                  : () => _submit,
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: Text(
                            state.signInStatus == SignInStatus.submiting
                                ? "Loading..."
                                : "Sign In",
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed:
                              state.signInStatus == SignInStatus.submiting
                                  ? null
                                  : () => Navigator.of(context)
                                      .pushNamed(SignUpPage.routeName),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[900]!,
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: const Text(
                            "Not a member? Sign Up",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
