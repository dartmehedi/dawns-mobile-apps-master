import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dawnsapp/Models/coupon_model.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CouponService with ChangeNotifier {
  int coupon = 0;
  bool isappliedCoupon = false;

  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  getcoupon() {
    return coupon;
  }

  setcoupon(value) {
    coupon = int.parse(value);
    notifyListeners();
  }

  setAppliedCouponTrue() {
    isappliedCoupon = true;
    notifyListeners();
  }

  setAppliedCouponFalse() {
    isappliedCoupon = false;
    notifyListeners();
  }

  var header = {
    //if header type is application/json then the data should be in jsonEncode method
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  fetchCoupon(enteredCoupon, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      OthersHelper().showToast("Please turn on your internet connection",
          ConstantColors().primaryColor);
    } else {
      if (enteredCoupon.isNotEmpty) {
        Provider.of<CouponService>(context, listen: false).setLoadingTrue();
        var response = await http.post(
            Uri.parse('https://dawnsapps.com/myapi/public/api/coupon'),
            body: jsonEncode({"coupon": enteredCoupon}),
            headers: header);

        if (response.statusCode == 201) {
          var data = CouponModel.fromJson(jsonDecode(response.body));
          setcoupon(data.discount);
          //make loading false
          Provider.of<CouponService>(context, listen: false).setLoadingFalse();
          //hide coupon input section
          Provider.of<CouponService>(context, listen: false)
              .setAppliedCouponTrue();
          //update total price value
          Provider.of<ProductService>(context, listen: false)
              .totalPriceAfterCouponApplied(int.parse(data.discount ?? '0'));
          //show toast
          OthersHelper().showToast(
              "Coupon Applied Successfully", ConstantColors().greenColor);
        } else {
          //make loading false
          Provider.of<CouponService>(context, listen: false).setLoadingFalse();
          print("coupon error is: ${response.body}");
          OthersHelper().showToast(
              "Please enter a valid coupon", ConstantColors().primaryColor);
        }
      } else {
        OthersHelper().showToast(
            "Please enter your coupon first", ConstantColors().primaryColor);
      }
    }
  }
}
