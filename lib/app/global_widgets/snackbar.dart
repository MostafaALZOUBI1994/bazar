import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnakBarBottom(String message, Color color) {
  Get.snackbar("بازاركم", message,
      backgroundColor: color,
      snackStyle: SnackStyle.FLOATING,
      margin:EdgeInsets.only(bottom: 30) ,
      borderRadius: 20,
      snackPosition: SnackPosition.BOTTOM);
}
showSnakBarTop(String message, Color color) {
  Get.snackbar("بازاركم", message,
      backgroundColor: color,
      borderRadius: 20, snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.TOP);
}
