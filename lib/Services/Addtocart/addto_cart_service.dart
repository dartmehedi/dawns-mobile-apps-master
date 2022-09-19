import 'package:dawnsapp/Services/Addtocart/db_service.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AddtoCartService with ChangeNotifier {
  List products = [];

  // int totalprice = 0;

  emptyLocalCart(BuildContext context) async {
    await DbService().emptyDb();
    getProducts();
  }

  getProducts() async {
    products = await DbService().readData();
    notifyListeners();
  }

  deleteData(prodId, productName, BuildContext context) async {
    await DbService().deleteData(prodId, productName, context);
    getProducts();
    Provider.of<ProductService>(context, listen: false).makeAlreadyAddedFalse();
  }

//increase quantity and price
  increaseQtandPrice(
      prodId, productName, quantity, BuildContext context) async {
    var data = await DbService().getquantity(prodId, productName);
    var qt = data[0]['quantity'] + quantity;
    var newprice = data[0]['singlePrice'] * qt; //will give us total price
    // print(qt);
    await DbService()
        .updateQtandPrice(prodId, productName, qt, newprice, context);
  }

  //decrease quantity and price
  decreaseQtandPrice(prodId, productName, BuildContext context) async {
    var data = await DbService().getquantity(prodId, productName);
    if (data[0]['quantity'] > 1) {
      var qt = data[0]['quantity'] - 1;

      var newprice = data[0]['totalPrice'] - data[0]['singlePrice'];

      await DbService()
          .updateQtandPrice(prodId, productName, qt, newprice, context);
    }

    // print(qt);
  }

  // totalPricefunction() async {
  //   totalprice = await DbService().getTotalPrice();
  //   notifyListeners();
  // }
}
