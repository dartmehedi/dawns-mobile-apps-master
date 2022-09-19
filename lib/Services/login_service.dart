import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dawnsapp/Models/login_model.dart';
import 'package:dawnsapp/Services/user_service.dart';
import 'package:dawnsapp/Views/Home/home.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Constants/constant_colors.dart';
import 'package:http/http.dart' as http;

class LoginService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  login(String email, String pass, bool loginFromOrder,
      BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      OthersHelper()
          .showToast("Please turn on your internet connection", Colors.black);
    } else {
      if (email.isEmpty) {
        OthersHelper().showToast(
            "Name field cannot be empty", ConstantColors().primaryColor);
      } else if (!email.contains("@")) {
        OthersHelper()
            .showToast("Invalid email", ConstantColors().primaryColor);
      } else if (pass.isEmpty) {
        OthersHelper().showToast(
            "pass field cannot be empty", ConstantColors().primaryColor);
      } else {
        Provider.of<LoginService>(context, listen: false).setLoadingTrue();
        var data = jsonEncode({
          'email': email,
          'password': pass,
        });
        var header = {
          //if header type is application/json then the data should be in jsonEncode method
          "Accept": "application/json",
          "Content-Type": "application/json"
        };

        var response = await http.post(
            Uri.parse('https://dawnsapps.com/myapi/public/api/auth/login'),
            body: data,
            headers: header);

        if (response.statusCode == 200) {
          var data = LoginModel.fromJson(jsonDecode(response.body));
          //save the token and token type in local db and get the user details from db

          //if logged in from order page then don't push to homepage
          if (loginFromOrder == false) {
            OthersHelper()
                .showToast("Login successful", ConstantColors().greenColor);
            Provider.of<LoginService>(context, listen: false).setLoadingFalse();
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          }

          savetolocalAndGet_details_fromDb(
              data.accessToken, data.tokenType, loginFromOrder, context);
        } else {
          print("login error is ${response.body}");
          Provider.of<LoginService>(context, listen: false).setLoadingFalse();
          OthersHelper().showToast(
              "Login failed. Make sure your email and password is correct",
              ConstantColors().primaryColor);
        }
      }
    }
  }

//save access token to local database
  savetolocalAndGet_details_fromDb(
      token, tokenType, bool isloginfromorder, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('tokenType', tokenType);

    if (isloginfromorder == false) {
      Provider.of<UserService>(context, listen: false)
          .getUserDetails(token, tokenType, context);
    }

    //load user data
  }
}
