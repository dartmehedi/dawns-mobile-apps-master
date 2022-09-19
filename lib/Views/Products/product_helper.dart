import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';

class ProductHelper {
  // getunit(var data) {
  //   var a = data.toString().split(".");
  //   return a[1];
  // }

  Widget placeOrderBottomSection(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: InkWell(
          onTap: () {
            ProductService().calculateTotalPrice();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CartPage()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 50,
            color: ConstantColors().primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Place order :   ৳ ${Provider.of<ProductService>(context, listen: true).totalPrice}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 17),
                ),
                const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ));
  }
}
