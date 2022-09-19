import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dawnsapp/Models/email_taken_model.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/login_service.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class SignUpService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  register(
      String name,
      String email,
      String pass,
      String confirmPass,
      String mobile,
      String address,
      bool isfromOrderPage,
      BuildContext context) async {
    // check connection first
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      OthersHelper()
          .showToast("Please turn on your internet connection", Colors.black);
    } else {
      //internet is on. So, proceed
      //================== validating input fields ====================>
      if (name.isEmpty) {
        OthersHelper().showToast(
            "Name field cannot be empty", ConstantColors().primaryColor);
      } else if (!email.contains("@")) {
        OthersHelper()
            .showToast("Invalid email", ConstantColors().primaryColor);
      } else if (mobile.isEmpty) {
        OthersHelper().showToast(
            "Mobile field cannot be empty", ConstantColors().primaryColor);
      } else if (mobile.length < 11 || mobile.length > 11) {
        OthersHelper().showToast(
            "Invalid mobile number. Expected 11 characters",
            ConstantColors().primaryColor);
      } else if (address.isEmpty) {
        OthersHelper().showToast(
            "Please enter your address", ConstantColors().primaryColor);
      } else if (email.isEmpty) {
        OthersHelper().showToast(
            "Email field cannot be empty", ConstantColors().primaryColor);
      } else if (pass.isEmpty) {
        OthersHelper().showToast(
            "pass field cannot be empty", ConstantColors().primaryColor);
      } else if (confirmPass.isEmpty) {
        OthersHelper().showToast(
            "Please confirm your password", ConstantColors().primaryColor);
      } else if (pass != confirmPass) {
        OthersHelper()
            .showToast("Password didn't match", ConstantColors().primaryColor);
      } else {
        Provider.of<SignUpService>(context, listen: false).setLoadingTrue();
        var data = jsonEncode({
          'name': name,
          'email': email,
          'password': pass,
          'mobile': mobile,
          'address': address
        });
        var header = {
          //if header type is application/json then the data should be in jsonEncode method
          "Accept": "application/json",
          "Content-Type": "application/json"
        };
        var response = await http.post(
            Uri.parse('https://dawnsapps.com/myapi/public/api/register'),
            body: data,
            headers: header);

        if (response.statusCode == 200) {
          OthersHelper().showToast(
              'Successfully registered', ConstantColors().greenColor);

          // run the login function and make user logged in automatically
          LoginService().login(email, pass, isfromOrderPage, context);
          Provider.of<SignUpService>(context, listen: false).setLoadingFalse();

          // OthersHelper().showToast('Please login to continue', Colors.black);
        } else if (response.statusCode == 422) {
          Provider.of<SignUpService>(context, listen: false).setLoadingFalse();
          //if email has already taken

          var data = EmailTakenModel.fromJson(jsonDecode(response.body));
          OthersHelper()
              .showToast(data.errors.email[0], ConstantColors().primaryColor);
        } else {
          //if something goes wrong
          Provider.of<SignUpService>(context, listen: false).setLoadingFalse();
          print("Sign up wrong problem is: ${response.statusCode}");
          print(jsonDecode(response.body));
          OthersHelper()
              .showToast("Registration failed", ConstantColors().primaryColor);
        }
      }
    } //internet check bracket
  }
}
