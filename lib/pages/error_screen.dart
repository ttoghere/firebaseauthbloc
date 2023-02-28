import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  static const String routeName = "/error";
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Check your Internet connection",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
