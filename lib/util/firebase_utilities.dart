import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:collection/collection.dart';
import 'package:mis_app/models/user_model.dart';

class FirebaseUtilities {
  static var firebaseInstance = auth.FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<bool> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      print('FireStoreUtils.createUserWithEmailAndPassword');
      auth.UserCredential result = await firebaseInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      print('creds: ' + (result.user?.uid ?? 'Fail'));
      if ((result.user?.uid ?? '') != '') {
        _saveStudentData(User(
            email: email, userId: result.user?.uid ?? '', userType: 'STUDENT'));
        return true;
      }
    } on auth.FirebaseAuthException catch (exception, s) {
      print(exception.toString() + '$s');
    } catch (e, s) {
      print(e.toString() + '$s');
    }
    return false;
  }

  static Future<bool> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      print('FireStoreUtils.loginWithEmailAndPassword');
      auth.UserCredential result = await firebaseInstance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on auth.FirebaseAuthException catch (exception, s) {
      print(exception.toString() + '$s');
      return false;
    } catch (e, s) {
      print(e.toString() + '$s');
      return false;
    }
  }

  static Future<bool> _saveStudentData(User user) async {
    await firestore.collection('USERS').doc().set(user.toJson()).then(
        (document) {
      return true;
    }, onError: (e, s) {
      return false;
    });
    return false;
  }
}
