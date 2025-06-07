import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playmate/Utilities/mycontroller.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final MyController c = Get.put(MyController());

  User? _user;

  User? get user {
    return _user;
  }

  User? get getUser {
    return _firebaseAuth.currentUser;
  }

  AuthService() {
    _firebaseAuth.authStateChanges().listen(authStateChangeStreamListener);
  }

  Future<bool> loginUsingEmailAndPassword(String email, String password,
      String? phone, String? address, String? name) async {
    // if (kDebugMode) {
    //   print('result - email 1:$email');
    //   print('result - phone 1:$password');
    // }

    try {
      final credentials = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user != null) {
        _user = credentials.user;
        // if (kDebugMode) {
        //   print('_user ${credentials.toString()}');
        // }
        // _firebase.collection("fmusers").doc(credentials.user!.uid).set(
        //   {
        //     'uid': credentials.user!.uid,
        //     'name': name,
        //     'email': email,
        //     'password': password,
        //     'phone': phone,
        //     'address': address,
        //     "dob": "",
        //     "created_date": "",
        //     "plan_created_date": "",
        //     "plan_expired_date": "",
        //     "plan_name": "",
        //     "imageurl": "N/A"
        //   },
        // Get.find<MyController>().profiledata.value = credentials.toString();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Get.snackbar('Error!.', 'Please verify the username and/or password!',
          barBlur: 1,
          backgroundColor: Colors.white,
          margin: const EdgeInsets.all(.1),
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.BOTTOM);

      return false;
    }
    // return false;
  }

  Future<String?> registerUserUsingEmailAndPassword(String email,
      String password, String? phone, String? address, String? name) async {
    //print('creating user');
    try {
      UserCredential credentials = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      //print('_user $_user');
      // _firebase.collection("fmusers").doc(credentials.user!.uid).set(
      //   {
      //     'uid': credentials.user!.uid,
      //     'name': name,
      //     'email': email,
      //     'password': password,
      //     'phone': phone,
      //     'address': address,
      //     "dob": "",
      //     "created_date": "",
      //     "plan_created_date": "",
      //     "plan_expired_date": "",
      //     "plan_name": "",
      //     "imageurl": "N/A"
      //   },
      // );
      return credentials.user!.uid;
    } on FirebaseAuthException {
      stderr.write("Error registering user.");
    } catch (e) {
      stderr.write(e);
    }
    return null;
  }

  Future<bool> logout() async {
    // if (kDebugMode) {
    //   print(_firebaseAuth);
    // }
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      stderr.write(e);
    }
    return false;
  }

  void authStateChangeStreamListener(User? user) async {
    if (user != null) {
      _user = user;
      //print('user.email: ${user.email}');
      // const start = "quick";
      late String phone;
      Map<dynamic, dynamic> userData;
      const end = "@";

      const startIndex = 0;
      final endIndex = user.email!.indexOf(end);

      phone = user.email!.substring(startIndex + 0, endIndex);
      //print('phone: $phone');
      // final QuerySnapshot resulta = await _firebase
      //     .collection("fmusers")
      //     .where("email", isEqualTo: user.email)
      //     .get();
      final QuerySnapshot resulta = await _firebase
          .collection("customers")
          .where("_phone", isEqualTo: phone)
          .get();

      List<Object?> data = resulta.docs.map((e) {
        return e.data();
      }).toList();
      //print('data:$data');
      // final List<DocumentSnapshot> documents = resulta.docs;
      // if (documents.isNotEmpty) {
      if (data.isNotEmpty) {
        userData = data[0] as Map;

        final QuerySnapshot resultb = await FirebaseFirestore.instance
            .collection("admin")
            .where("_phone", isEqualTo: phone)
            .get();

        List<Object?> dataadmin = resultb.docs.map((e) {
          return e.data();
        }).toList();

        if (dataadmin.isNotEmpty) {
          Map<dynamic, dynamic> adminData = dataadmin[0] as Map;
        }
        // if (kDebugMode) {
        //   print('userData A:$userData');
        // }
        Get.find<MyController>().profiledata = userData;

        //get user

        // if (isAdmin) {
        //   _navigationService.pushNamed("/adminhome");
        // } else if (isDriver) {
        //   _navigationService.pushNamed("/driverhome");
        // } else {
        //   _navigationService.pushNamed("/home");
        // }
      }
    } else {
      _user = null;
    }
  }

  Future<void> getfooddetails() async {
    final FirebaseFirestore firebase = FirebaseFirestore.instance;
    final QuerySnapshot resulta =
        await firebase.collection("fmstations").orderBy("free").get();

    List<Object?> data = resulta.docs.map((e) {
      return e.data();
    }).toList();

    if (data.isNotEmpty) {
      Map<dynamic, dynamic> fooditems = data[0] as Map;
      if (kDebugMode) {
        print('in main: $fooditems');
      }
    }
  }
}
