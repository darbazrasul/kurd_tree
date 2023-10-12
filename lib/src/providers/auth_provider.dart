import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:kurd_tree/src/helper/k_helper.dart';
import 'package:kurd_tree/src/models/kt_user_model.dart';
import 'package:kurd_tree/src/screens/login_screen.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? get fireUser => FirebaseAuth.instance.currentUser;

  KTUser? _user;
  // user getter
  KTUser? get user => _user;
  // user setter
  set user(KTUser? user) {
    _user = user;
    notifyListeners();
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? _userStream;

  Future<bool> registerWithEmailPassword(
      {required String email, required String password}) async {
    UserCredential userCredential;

    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        KHelper.showSnackBar('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        KHelper.showSnackBar('The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        KHelper.showSnackBar('The email address is not valid.');
      } else if (e.code == 'operation-not-allowed') {
        KHelper.showSnackBar(
            'The email/password accounts are not enabled. Enable them in the Auth section of the Firebase console.');
      } else {
        KHelper.showSnackBar("Error 6261:${e.code}: ${e.message}");
      }
      notifyListeners();
      return false;
    }

    if (userCredential.user == null) {
      KHelper.showSnackBar("Something went wrong please try again");
      await FirebaseAuth.instance.signOut();
      notifyListeners();
      return false;
    }

    await _crateProfileForUser();
    debugPrint("User Created");

    _listenToUser();

    notifyListeners();
    return true;
  }

  Future<bool> loginWithEmailPassword(
      {required String email, required String password}) async {
    UserCredential userCredential;

    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        KHelper.showSnackBar('No user found for that email.');
      } else if (e.code == 'invalid-email') {
        KHelper.showSnackBar('The email address is not valid.');
      } else if (e.code == 'user-disabled') {
        KHelper.showSnackBar('The user is disabled.');
      } else if (e.code == 'wrong-password') {
        KHelper.showSnackBar('The password is wrong.');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        KHelper.showSnackBar('The password or email are wrong. ');
      } else {
        KHelper.showSnackBar("${e.code}: ${e.message}");
        print(e.code);
      }
      notifyListeners();
      return false;
    }

    if (userCredential.user == null) {
      KHelper.showSnackBar("Something went wrong please try again");
      await FirebaseAuth.instance.signOut();
      notifyListeners();
      return false;
    }

    debugPrint("User Logged in");
    _listenToUser();
    notifyListeners();
    return true;
  }

  _crateProfileForUser() async {
    if (fireUser == null) {
      debugPrint("User is null");
      return;
    }

    user = await KTUser(
      uid: fireUser!.uid,
      email: fireUser!.email,
    );

    user?.save();

    notifyListeners();
  }

  _listenToUser() {
    if (fireUser?.uid == null) {
      print("User is null 4654");
      return;
    }

    _userStream?.cancel();
    _userStream = null;

    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(fireUser!.uid)
        .snapshots()
        .listen((event) {
      if (!event.exists) {
        signOut();
        return;
      }
      if (event.data() == null) return;
      user = KTUser.fromMap(event.data() as Map<String, dynamic>);
      notifyListeners();
    });

    print("Listening to user");
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await _userStream?.cancel();
    _userStream = null;
    user = null;
    notifyListeners();
    Get.offAll(() => const LoginScreen());
    print("User Signed out");
  }

  Future<bool> checkUserIsLoggedIn() async {
    if (fireUser == null) {
      return false;
    }
    _listenToUser();
    return true;
  }
}
