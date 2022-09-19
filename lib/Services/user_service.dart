import 'dart:convert';

import 'package:dawnsapp/Models/userdetails_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UserService with ChangeNotifier {
  var userDetails;
  bool isLoading = false;

  getLoading() {
    return isLoading;
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  getUserDetails(token, tokenType, context) async {
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "$tokenType $token"
    };

    var response = await http.post(
        Uri.parse('https://dawnsapps.com/myapi/public/api/auth/me'),
        headers: header);

    if (response.statusCode == 200) {
      userDetails = UserDetailsModel.fromJson(jsonDecode(response.body));
      notifyListeners();
      isLoading = false;
    } else {
      print("error is ${response.body}");
    }
  }
}
