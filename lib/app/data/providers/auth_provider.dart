import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/models/user_model.dart';
import 'package:bazarcom/app/global_widgets/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class AuthApiClient {
  User user;
  Future<User> register(String name, String email, String password,String phoneNumber) async {
    final resp = await strapiClient.register(
      name,
      email,
      password,
      phoneNumber,
    );
    resp.map(ok: (ok) {
      print(ok.toString());
      user = User.fromJson(ok.data);
    }, error: (e) {
      showSnakBarBottom(e.message, kColorOfYellowRect);
    });
    return user;
  }

  Future<User> login(String email, String password) async {
    final resp = await strapiClient.login(
      email,
      password,
    );
    resp.map(ok: (ok) {
      print(ok.toString());
      user = User.fromJson(ok.data);
    }, error: (e) {
      showSnakBarTop(
        e.message,kColorOfBlueRect
      );
    });
    return user;
  }


  Future<User> getUserProfile(String token) async {
     final resp = await strapiClient.me(
       options: Options(headers: {
         'Authorization': "Bearer "+token,
       })
     );
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
}
