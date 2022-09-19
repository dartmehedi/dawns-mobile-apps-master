import 'package:flutter/material.dart';

class AuthHelper {
  //Login circle 1
  Widget loginCircle1() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffED1B2F),
              Color(0xffFC5B31),
            ],
          ),
          color: Color(0xff139BE8),
          shape: BoxShape.circle),
    );
  }

  //Login circle 2
  Widget loginCircle2() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: 70,
      width: 70,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffED1B2F),
              Color(0xffFC5B31),
            ],
          ),
          color: Color(0xff139BE8),
          shape: BoxShape.circle),
    );
  }
}
