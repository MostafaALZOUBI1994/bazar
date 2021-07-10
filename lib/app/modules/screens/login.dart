import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/data/providers/auth_provider.dart';
import 'package:bazarcom/app/global_widgets/snackbar.dart';
import 'package:bazarcom/app/modules/controllers/auth_controller.dart';
import 'package:bazarcom/app/utils/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class Login extends StatelessWidget {
  final AuthController authController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const Login(
      {Key key,
      this.authController,
      this.emailController,
      this.passwordController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        /*
        Text(
          "Welcome to",
          style: TextStyle(
            fontSize: 16,
            color: kColorOfCanvas,
            height: 2,
          ),
        ),

        Text(
          "HOMELAND",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: kColorOfCanvas,
            letterSpacing: 2,
            height: 1,
          ),
        ),

        Text(
          "Please login to continue",
          style: TextStyle(
            fontSize: 16,
            color: kColorOfCanvas,
            height: 1,
          ),
        ),

        SizedBox(
          height: 16,
        ),
*/
        Center(
          child: Image.asset(
            "assets/images/6.png",
            height: deviceHieght / 6,
          ),
        ),
        SizedBox(
          height: deviceHieght / 30,
        ),
        TextFormField(autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (!GetUtils.isEmail(value)) {
              return "أدخل إيميلك بشكل صحيح";
            } else
              return null;
          },
          controller: emailController,
          decoration: InputDecoration(
            hintText: LocaleKeys.email.tranlation(),
            hintStyle: TextStyle(
              color: kColorOfYellowRect,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: kColorOfCanvas,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: LocaleKeys.password.tranlation(),
            hintStyle: TextStyle(
              color: kColorOfYellowRect,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            filled: true,
            fillColor: kColorOfCanvas,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(
          height: 24,
        ),
        InkWell(
          onTap: () async {
            emailController.text.isEmpty || passwordController.text.isEmpty
                ? showSnakBarTop("رجاء إملأ كافة الحقول", kColorOfCanvas,)
                : authController.login(
                    emailController.text, passwordController.text);
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: kColorOfCanvas,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: kColorOfCanvas.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                LocaleKeys.login.tranlation(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorOfYellowRect,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            AuthApiClient().forgetPassword();
          },
          child: Text(
            LocaleKeys.forgotPassword.tranlation(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: kColorOfCanvas,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
