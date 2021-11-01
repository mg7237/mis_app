import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:mis_app/models/student_model.dart';
import 'package:mis_app/models/user_model.dart';
import 'package:mis_app/models/adviser_model.dart';

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

  static Future<bool> createStudent(Student student) async {
    await firestore.collection('STUDENT').doc().set(student.toJson()).then(
        (document) {
      return true;
    }, onError: (e, s) {
      return false;
    });
    return false;
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

  static Future<List<Adviser>> getAdvisers() async {
    List<Adviser> advisors = [];
    try {
      var result = await firestore.collection("ADVISERS").get();
      if (result.docs.length > 0) {
        List<QueryDocumentSnapshot<Map<String, dynamic>>> advisorsData =
            result.docs;
        advisorsData.forEach((element) {
          advisors.add(Adviser.fromMap(element.data()));
        });
      }
    } catch (e) {
      print(e.toString());
    }
    return advisors;
  }

  static Future<User?> getUser(String emailId) async {
    User? user;
    try {
      QuerySnapshot<Map<String, dynamic>> result = await firestore
          .collection("USERS")
          .where("email", isEqualTo: emailId)
          .get();
      if (result.docs.length > 0) {
        user = User.fromJson(result.docs[0].data());
      }
    } catch (e) {
      print(e.toString());
    }
    return user;
  }
}
