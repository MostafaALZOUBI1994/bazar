import 'package:bazarcom/app/constants.dart';
import 'package:bazarcom/app/utils/utils/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
class SignUpOption extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          LocaleKeys.or.tranlation(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1,
            color:kColorOfYellowRect
          ),
        ),

        SizedBox(
          height: deviceHieght/30,
        ),

        Container(
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
          child:  Center(
            child: Text(
              LocaleKeys.signUp.tranlation(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorOfCanvas,
              ),
            ),
          ),
        ),

      ],
    );
  }
}