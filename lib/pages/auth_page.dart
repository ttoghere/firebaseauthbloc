import 'package:firebaseauthbloc/pages/signIn_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  static const String routeName = "/auth";
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              "Auth Page",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(LoginPage.routeName);
            },
            child: Text("Sign In"),
          ),
        ],
      ),
    );
  }
}
