import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  static const String routeName = "/signin";
  SignInPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  String? _email;
  String? _password;
  void _submit() {}
  @override
  Widget build(BuildContext context) {
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
                    prefixIcon: Icon(Icons.alternate_email_outlined),
                  ),
                  validator: (String? value){
                    if(value == null  )
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
