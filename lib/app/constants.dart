
import 'package:dart_strapi/dart_strapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///===============Colors:===============//
//Canvas color (bg):
const Color kColorOfCanvas = Color(0xFF18294D); //#18294D
//RectColors:
const Color kColorOfYellowRect = Color(0xFFFEBF49); //#FEBF49
const Color kColorOfOrangeRect = Color(0xFFFF832A); //#FF832A
const Color kColorOfBlueRect = Color(0xFF27437D); //#27437D
//Orange color:
const Color kOrangeColor = Color(0xFFFF832A); //#FF832A
//White with opacity color:
const Color kWhiteWithOpacity = Color.fromRGBO(255, 255, 255, 0.3);
//Button Orange Gradient:
const Gradient kOrangeGradient = LinearGradient(
  colors: [
    Color(0xFFFFAB0C), //#FFAB0C
    Color(0xFFEB6733), //#EB6733
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

var deviceWidth=Get.width;

var deviceHieght=Get.height;

final strapiClient = Strapi(
 baseUrl,
  // token: 'token',
);

const baseUrl = 'http://192.168.1.101:1337';
