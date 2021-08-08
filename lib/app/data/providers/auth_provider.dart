import 'dart:convert';

import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/user_model.dart';
import 'package:bazarcom/app/global_widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class AuthApiClient {
  User user;
  Future<User> register(
      String name, String email, String password, String phoneNumber) async {
    String token = await getToken();
    final resp =
        await strapiClient.register(name, email, password, phoneNumber, token);
    resp.map(ok: (ok) {
      print(ok.toString());
      user = User.fromJson(ok.data, token);
      showSnakBarTop("تم إنشاء حساب بنجاح", kColorOfBlueRect);
    }, error: (e) {
      showSnakBarBottom(e.message, kColorOfYellowRect);
    });
    return user;
  }

  Future<User> login(String email, String password) async {
    String token = await getToken();
    final resp = await strapiClient.login(
      email,
      password,
    );
    resp.map(ok: (ok) async {
      print(ok.toString());
      user = User.fromJson(ok.data, token);
      var gf = await editFcmToken(user.fcmToken, user.id.toString(), user.jwt);
      print(gf.toString());
      showSnakBarTop("تم تسجيل الدخول بنجاح", kColorOfBlueRect);
    }, error: (e) {
      showSnakBarTop(e.message, kColorOfBlueRect);
    });
    return user;
  }

  Future editFcmToken(String newFcmToken, String userId, String jwt) async {
    var fcmRequest = await strapiClient.updateFcm(userId, jwt, newFcmToken);
    print(fcmRequest.toString());
  }

  Future<User> getUserProfile(String token) async {
    final resp = await strapiClient.me(
        options: Options(headers: {
      'Authorization': "Bearer " + token,
    }));
    resp.map(ok: (ok) {
      print(ok.toString());
      user = User.ProfilefromJson(ok.data);
    }, error: (e) {
      Get.snackbar(
        "re",
        e.message,
      );
    });
    return user;
  }

  forgetPassword() async {
    final resp = await strapiClient.forgotPassword(
      'mostafaalzoubi1994@gmail.com',
    );
    print(resp.toString());
  }

  getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    return messaging.getToken();
  }
}
