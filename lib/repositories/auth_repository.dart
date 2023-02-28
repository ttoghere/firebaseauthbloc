// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:firebaseauthbloc/constants/db_constants.dart';
import 'package:firebaseauthbloc/models/custom_error.dart';

class AuthRepository {
  //Parameter1: firestore variable
  final FirebaseFirestore firebaseFirestore;
  //Parameter2: auth variable
  final fbAuth.FirebaseAuth firebaseAuth;
  AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });
  //This method tracks the auth user change
  //We will use it for init route
  Stream<fbAuth.User?> get user => firebaseAuth.userChanges();

  //User SignUp function for FirebaseAuth
  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    try {
      //The function of create a new user with email and password on authserver
      final fbAuth.UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //User Check
      final signedInUser = userCredential.user!;
      //FirebaseFirestore function for the specific user
      await usersRef.doc(signedInUser.uid).set({
        "name": name,
        "email": email,
        "profileImage": "https://picsum.photos/300",
        "point": 0,
        "rank": "bronze"
      });
    } on fbAuth.FirebaseAuthException catch (error) {
      throw CustomError(
        code: error.code,
        message: error.message!,
        plugin: error.plugin,
      );
    } catch (e) {
      throw CustomError(
          code: "Exception",
          message: e.toString(),
          plugin: "flutter_error/server_error");
    }
  }

  //User Login Function for FirebaseAuth
  Future<void> signIn({required String email, required String password}) async {
    try {
      //Login function
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on fbAuth.FirebaseAuthException catch (error) {
      throw CustomError(
        code: error.code,
        message: error.message!,
        plugin: error.plugin,
      );
    } catch (e) {
      throw CustomError(
          code: "Exception",
          message: e.toString(),
          plugin: "flutter_error/server_error");
    }
  }

  //User LogOut Function for FirebaseAuth
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
