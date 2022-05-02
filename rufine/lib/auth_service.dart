import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart" as auth;
import 'package:flutter/material.dart';
import 'package:rufine/models/user_model.dart';

import 'dashboard.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid, email: user.email);
  }

  Stream<User?>? get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<User?> signInwithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      var collection = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .get();
      print(collection.data());
      return _userFromFirebase(result.user);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String name, BuildContext context) async {
    try {
      final auth.UserCredential result =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .set({'username': name, 'email': email});
      final auth.User? user = result.user;
      user!.updateDisplayName(name);
      print(user.displayName);
      return _userFromFirebase(result.user);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
