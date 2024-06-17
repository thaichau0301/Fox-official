import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fox/domain/googleauth/google_auth_helper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/app_export.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    GetInfoUser();
  }
  Rx<UserModel> userModelObj = UserModel().obs;
  User? firebaseUser;
  FirebaseAuth auth = FirebaseAuth.instance;
  final googleController = Get.put(GoogleAuthHelper());
  RxString email = ''.obs;
  RxString photoUrl = ''.obs;

  void showAlertDialog() {
    Get.dialog(
      AlertDialog(title: Center(child: Text('You must login', )),),
    );
    Timer(Duration(seconds: 1), () {
      Get.back();
    });
  }
  void GetInfoUser()
  {
    auth.authStateChanges().listen((User? user) {
      firebaseUser = auth.currentUser;
      if(firebaseUser != null) {
        email.value = firebaseUser!.email!;
        photoUrl.value =  firebaseUser!.photoURL!;
      }
      else {
        email.value = '';
        photoUrl.value = '';
      }
    update();
  }
    );
  }


  Future<void> SignOutUser() async
  {
    if (firebaseUser != null)
    {
      for (UserInfo userInfo in firebaseUser!.providerData)
      {
        if (userInfo.providerId == 'facebook.com')
        {
          await FacebookAuth.instance.logOut();
        }
        else if (userInfo.providerId == 'google.com')
        {
          await GoogleSignIn().signOut();
        }
      }
      await FirebaseAuth.instance.signOut();
      deleteAllController();
    }
    else {
      showAlertDialog();
    }
  }
  Future<void> DeleteAccount() async {
    if (firebaseUser != null)
    {
      for (UserInfo userInfo in firebaseUser!.providerData)
      {
        if (userInfo.providerId == 'facebook.com')
        {
          await FacebookAuth.instance.logOut();
        }
        else if (userInfo.providerId == 'google.com')
        {
          await GoogleSignIn().signOut();
        }
      }
      await firebaseUser!.delete();
      deleteAllController();
    }
    else {
      showAlertDialog();
    }
  }
  void deleteAllController() {
    Get.deleteAll(force: true);
  }
  void CheckEnterStudio() {
    if (auth.currentUser != null) {
      Get.toNamed('/studio_screen');
    } else {
      showAlertDialog();
    }
  }
}
