import 'dart:developer';

import 'package:firebaseauthbloc/blocs/Auth/auth_bloc.dart';
import 'package:firebaseauthbloc/pages/auth_page.dart';
import 'package:firebaseauthbloc/pages/error_screen.dart';
import 'package:firebaseauthbloc/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  static const routeName = "/";
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        log("state: $state");
        if (state.user == null) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushNamed(AuthPage.routeName);
          });
        } else if (state.user != null) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushNamed(HomePage.routeName);
          });
        } else {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pushNamed(ErrorPage.routeName);
          });
        }
      },
      builder: (context, state) {
        log("state: $state");
        return const Scaffold();
      },
    );
  }
}
