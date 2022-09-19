import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OthersHelper {
  int deliveryCharge = 60;

  List icon = [
    Icons.school,
    Icons.business_outlined,
    Icons.card_giftcard,
    Icons.architecture_sharp,
    Icons.school,
    Icons.business_outlined,
    Icons.card_giftcard,
    Icons.architecture_sharp,
    Icons.school,
    Icons.business_outlined,
    Icons.card_giftcard,
    Icons.architecture_sharp
  ];

  void showToast(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void toastShort(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
