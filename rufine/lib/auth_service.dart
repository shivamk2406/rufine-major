import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart" as auth;
import 'package:flutter/material.dart';
import 'package:rufine/models/user_model.dart';

import 'dashboard.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth;
  AuthService(this._firebaseAuth);

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(
        uid: user.uid, email: user.email, displayName: user.displayName);
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signIn(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      final auth.UserCredential result =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      //get From Database
      var collection = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .get();
      print(collection.data());

      auth.User? user = result.user;
      String? name = user!.displayName;

      print("user name: $name");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => Dashboard(),
        ),
      );
      return _userFromFirebase(result.user);
    } on auth.FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
      print(e.message);
      return null;
    }
  }

  Future<User?> signUp(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      final auth.UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("inside createUserWithEmailAndPassword");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set({'username': name, 'email': email});

      final auth.User? user = result.user;

      await user!.updateDisplayName(name);
      print("name $name email $email");
      print(user.displayName);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Dashboard(),
      ));
      return _userFromFirebase(result.user);
    } on auth.FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } on auth.FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }
}
