import 'package:dawnsapp/Models/addtocart_model.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../products_service.dart';
import 'addto_cart_service.dart';

class DbService {
  setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'cart_db');
    var database = await openDatabase(path, version: 1, onCreate: _dbOnCreate);
    return database;
  }

  _dbOnCreate(Database database, int version) async {
    await database.execute(
        "CREATE TABLE cart_products(id INTEGER PRIMARY KEY AUTOINCREMENT, productId INTEGER, productName TEXT, productImage TEXT, singlePrice INTEGER,totalPrice INTEGER, quantity INTEGER,unit TEXT)");
  }

  static Database? _database;
  Future<Database> get getdatabase async {
    if (_database != null) {
      //if the database already exists
      return _database!;
    } else {
      //else create the database and return it
      _database = await setDatabase();
      return _database!;
    }
  }

  checkProduct(productId, productName) async {
    var connection = await getdatabase;
    var prod = await connection.rawQuery(
        "SELECT * FROM cart_products WHERE productId=? and productName =?",
        [productId, productName]);

    if (prod.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  insertData(int productId, String productName, productImage, int singlePrice,
      int quantity, BuildContext context, unit) async {
    var connection = await getdatabase;
    var prod = await connection.rawQuery(
        "SELECT * FROM cart_products WHERE productId=? and productName =?",
        [productId, productName]);
    if (prod.isEmpty) {
      //if product is not already added to cart
      var cartObj = AddtocartModel();
      cartObj.productId = productId;
      cartObj.productName = productName;
      cartObj.productImage = productImage ?? "";
      cartObj.singlePrice = singlePrice;
      cartObj.quantity = quantity;
      cartObj.totalPrice = singlePrice * quantity;
      cartObj.unit = unit != null ? unit.toString() : "";
      await connection.insert('cart_products', cartObj.cartMap());

      Provider.of<ProductService>(context, listen: false)
          .calculateTotalPrice(); // this will show total price in homepage bottom layer
      Provider.of<ProductService>(context, listen: false)
          .makeAlreadyAddedTrue(); //this will hide the increase decrease button and add to cart button in product details page

      OthersHelper().toastShort("Added to cart", ConstantColors().greenColor);
    } else {
      //product already exist in cart. so increase it's quantity
      // await Provider.of<AddtoCartService>(context, listen: false)
      //     .increaseQtandPrice(productId, productName, quantity, context);

      Provider.of<ProductService>(context, listen: false)
          .calculateTotalPrice(); // this will show total price in homepage bottom layer

      OthersHelper().toastShort("Already added to cart.", Colors.black);
    }
  }

  readData() async {
    var connection = await getdatabase;
    return await connection.query('cart_products');
  }

  deleteData(int productId, String productname, BuildContext context) async {
    var connection = await getdatabase;
    await connection.rawDelete(
        "DELETE FROM cart_products WHERE productId=? and productName =?",
        [productId, productname]);

    Provider.of<ProductService>(context, listen: false)
        .calculateTotalPrice(); // this will show total price in homepage bottom layer

    // OthersHelper().toastShort("Removed from cart", Colors.black);
  }

  //quantity of a product
  getquantity(int productId, String productname) async {
    var connection = await getdatabase;
    var prod = connection.rawQuery(
        "SELECT * FROM cart_products WHERE productId=? and productName =?",
        [productId, productname]);
    return prod;
  }

  updateQtandPrice(int productId, String productname, int quantity, int price,
      BuildContext context) async {
    var connection = await getdatabase;
    connection.rawUpdate(
        "UPDATE cart_products SET quantity=?, totalPrice=? WHERE productId=? and productName =?",
        [quantity, price, productId, productname]);
    await Provider.of<AddtoCartService>(context, listen: false).getProducts();

    Provider.of<ProductService>(context, listen: false)
        .calculateTotalPrice(); // this will show total price
  }

  emptyDb() async {
    var connection = await getdatabase;
    var result = connection.rawQuery("DELETE FROM cart_products");
    return true;
  }

  // totalCartProducts() async {
  //   var connection = await getdatabase;
  //   var data = await connection.query('cart_products');
  //   if (data.isNotEmpty) {
  //     return data.length;
  //   } else {
  //     return 0;
  //   }
  // }

  // getTotalPrice() async {
  //   var connection = await getdatabase;
  //   List data = await connection.query('cart_products');
  //   int totalprice = 0;
  //   if (data.isNotEmpty) {
  //     for (int i = 0; i < data.length; i++) {
  //       totalprice = totalprice + data[i]['totalPrice'] as int;
  //       return totalprice;
  //     }
  //   } else {
  //     return 0;
  //   }
  // }
}
