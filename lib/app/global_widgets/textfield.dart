import 'package:bazarcom/app/constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const TextFieldWidget({Key key, this.controller, this.hint})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: kColorOfYellowRect, width: 2),
            color: kColorOfBlueRect),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(contentPadding: EdgeInsets.only(right: 8.0),
              border: InputBorder.none, hintText: hint, hintStyle: fieldsHint),
        ));
  }
}
