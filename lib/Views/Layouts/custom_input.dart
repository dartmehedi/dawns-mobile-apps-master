import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  final FocusNode? focusNode;
  final bool isNumberField;
  TextEditingController? controller;

  CustomInput(
      {Key? key,
      required this.hintText,
      required this.onChanged,
      required this.onSubmitted,
      this.textInputAction = TextInputAction.next,
      this.isPasswordField = false,
      this.focusNode,
      this.isNumberField = false,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 19),
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
            color: const Color(0xfff2f2f2),
            borderRadius: BorderRadius.circular(50)),
        child: TextField(
          controller: controller,
          keyboardType:
              isNumberField ? TextInputType.number : TextInputType.text,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: textInputAction,
          obscureText: isPasswordField,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 13, vertical: 13)),
        ));
  }
}
