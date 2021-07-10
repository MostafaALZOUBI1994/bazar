import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/utils/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class LoginOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          LocaleKeys.existingUser.tranlation(),
          style: TextStyle(color: kColorOfCanvas,
            fontSize: 16,
          ),
        ),

        SizedBox(
          height: 16,
        ),

        Container(
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
          child:  Center(
            child: Text(
              LocaleKeys.login.tranlation(),
              style: TextStyle(

                fontWeight: FontWeight.bold,
                color: kColorOfYellowRect,
              ),
            ),
          ),
        ),

      ],
    );
  }
}