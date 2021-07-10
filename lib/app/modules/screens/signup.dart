import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/global_widgets/snackbar.dart';
import 'package:bazarcom/app/modules/controllers/auth_controller.dart';
import 'package:bazarcom/app/utils/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  final AuthController authController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController phoneNumberController;
  const SignUp(
      {Key key,
      this.authController,
      this.emailController,
      this.passwordController,
      this.phoneNumberController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
/*
        Text(
          "Sign up with",
          style: TextStyle(

            color:kColorOfYellowRect,
            height: 2,
          ),
        ),

        Text(
          "HOMELAND",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: kColorOfYellowRect,
            letterSpacing: 2,
            height: 1,
          ),
        ),

        SizedBox(
          height: 16,
        ),

 */
        Center(
          child: Image.asset(
            "assets/images/2.png",
            height: deviceHieght / 6,
          ),
        ),
        SizedBox(
          height: deviceHieght / 30,
        ),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(height: deviceHieght / 30),
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
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(height: deviceHieght / 30),
        TextField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            hintText: LocaleKeys.phoneNumber.tranlation(),
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
            fillColor: Colors.grey.withOpacity(0.1),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          ),
        ),
        SizedBox(height: deviceHieght / 30),
        InkWell(
          onTap: () async {
            emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    phoneNumberController.text.isEmpty
                ? showSnakBarBottom("رجاء إملأ كافة الحقول", kColorOfYellowRect)
                : await authController.signUp(
                    emailController.text,
                    emailController.text,
                    passwordController.text,
                    phoneNumberController.text);
          },
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: kColorOfYellowRect,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: kColorOfYellowRect.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                LocaleKeys.signUp.tranlation(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kColorOfCanvas,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
