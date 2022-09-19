import 'package:dawnsapp/Services/Addtocart/db_service.dart';
import 'package:flutter/cupertino.dart';

class ProductService with ChangeNotifier {
  int totalPrice = 0;
  int totalCartProductsNumber = 0;

  getTotalPrice() {
    return totalPrice;
  }

  setPriceAndCount(price, totalproducts) {
    totalPrice = price;
    totalCartProductsNumber = totalproducts;
    notifyListeners();
  }

  // cartProductsNumber() async {
  //   totalCartProductsNumber = await DbService().totalCartProducts();
  //   notifyListeners();
  // }

  totalPriceAfterCouponApplied(discount) {
    totalPrice = (totalPrice - discount) as int;
    notifyListeners();
  }

  var alreadyAdded = false;
  checkIfAlreadyAddedToCart(id, productName) async {
    alreadyAdded = await DbService().checkProduct(
      id,
      productName,
    );
    notifyListeners();
  }

  makeAlreadyAddedTrue() {
    alreadyAdded = true;
    notifyListeners();
  }

  makeAlreadyAddedFalse() {
    alreadyAdded = false;
    notifyListeners();
  }

  calculateTotalPrice() async {
    List products = await DbService().readData();
    totalPrice = 0;
    if (products.isNotEmpty) {
      for (int i = 0; i < products.length; i++) {
        totalPrice = totalPrice + products[i]["totalPrice"] as int;
      }
      setPriceAndCount(totalPrice, products.length);
    } else {
      setPriceAndCount(0, 0);
    }
    // print(products[0]["productName"]);
  }
}
