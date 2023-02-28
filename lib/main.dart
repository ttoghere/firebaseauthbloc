import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthbloc/blocs/Auth/auth_bloc.dart';
import 'package:firebaseauthbloc/cubits/signIn/sign_in_cubit.dart';
import 'package:firebaseauthbloc/pages/auth_page.dart';
import 'package:firebaseauthbloc/pages/error_screen.dart';
import 'package:firebaseauthbloc/pages/home_page.dart';
import 'package:firebaseauthbloc/pages/profile_page.dart';
import 'package:firebaseauthbloc/pages/sign_in_page.dart';
import 'package:firebaseauthbloc/pages/sign_up_page.dart';
import 'package:firebaseauthbloc/pages/splash_page.dart';
import 'package:firebaseauthbloc/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //On top tier we have to define repositories first
    //Because their parameters are don't bloc
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: FirebaseAuth.instance),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            //On this provider we used a repository as parameter
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => SignInCubit(
              context.read<AuthRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          routes: {
            SplashPage.routeName: (context) => const SplashPage(),
            ProfilePage.routeName: (context) => ProfilePage(),
            SignInPage.routeName: (context) => SignInPage(),
            SignUpPage.routeName: (context) => SignUpPage(),
            HomePage.routeName: (context) => HomePage(),
            AuthPage.routeName: (context) => AuthPage(),
            ErrorPage.routeName: (context) => ErrorPage(),
          },
          initialRoute: SplashPage.routeName,
        ),
      ),
    );
  }
}
