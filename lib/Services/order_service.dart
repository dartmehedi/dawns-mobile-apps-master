import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:dawnsapp/Services/Addtocart/addto_cart_service.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/email_service.dart';
import 'package:dawnsapp/Services/orderDb/order_db_service.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Services/signup_service.dart';
import 'package:dawnsapp/Services/sms_service.dart';
import 'package:dawnsapp/Views/Delivery/order_success.dart';
import 'package:dawnsapp/Views/Others/invoice_layout.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:dawnsapp/Views/invoice/api/pdf_invoice_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'coupon_service.dart';

class OrderService with ChangeNotifier {
  bool loading = false;

  setLoadingTrue() {
    loading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    loading = false;
    notifyListeners();
  }

  placeOrder(
      BuildContext context,
      name,
      phone,
      address,
      notes,
      couponDiscount,
      deliveryCharge,
      grandTotal,
      subtotal,
      billingMobile,
      transactionId,
      paymentMethod,
      billingAmount,
      bool alreadyPaid,
      bool createAccountforLater,
      email,
      password) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      OthersHelper()
          .showToast("Please turn on your internet connection", Colors.black);
    } else {
      var products =
          Provider.of<AddtoCartService>(context, listen: false).products;

      if (name.isEmpty) {
        OthersHelper().showToast("Name field cannot be empty", Colors.black);
      } else if (phone.isEmpty) {
        OthersHelper().showToast("Phone field cannot be empty", Colors.black);
      } else if (phone.length < 11 || phone.length > 11) {
        OthersHelper().showToast(
            "Invalid mobile number. Expected 11 characters", Colors.black);
      } else if (address.isEmpty) {
        OthersHelper().showToast("Address field cannot be empty", Colors.black);
      } else if (alreadyPaid == true && billingMobile.isEmpty) {
        OthersHelper()
            .showToast("Enter your billing phone number", Colors.black);
      } else if (alreadyPaid == true && billingAmount.isEmpty) {
        OthersHelper().showToast("Enter the amount you paid", Colors.black);
      } else if (alreadyPaid == true && transactionId.isEmpty) {
        OthersHelper()
            .showToast("Enter the transaction ID of the payment", Colors.black);
      } else if (createAccountforLater == true && !email.contains("@")) {
        OthersHelper().showToast("Invalid email", Colors.black);
      } else if (createAccountforLater == true && password.isEmpty) {
        OthersHelper()
            .showToast("Password field cannot be empty", Colors.black);
      } else {
        Provider.of<OrderService>(context, listen: false).setLoadingTrue();
        //proceed to order
        List productList = [];
        for (int i = 0; i < products.length; i++) {
          var productMap = Map<String, dynamic>();
          productMap['product_id'] = products[i]['productId'];
          productMap['product_name'] = products[i]['productName'];
          productMap['qty'] = products[i]['quantity'];
          productMap['singleprice'] = products[i]['singlePrice'];
          productMap['totalprice'] = products[i]['totalPrice'];
          productMap['product_image'] = products[i]['productImage'];
          // print(products[i]['totalPrice']);
          productList.add(productMap);
        }

        if (productList.isNotEmpty) {
          var data = jsonEncode({
            'user_id': 0,
            'billing_name': name,
            'billing_mobile': billingMobile ?? '01789564542',
            'billing_address': address,
            'payment_method': paymentMethod,
            'amount': billingAmount, //amount he paid in bkash ucash etc
            'transaction_id': transactionId ?? '0',
            'subtotal': subtotal,
            'total': grandTotal,
            'delivery_charge': deliveryCharge,
            'coupon_discount': couponDiscount,
            'number': phone,
            'notes': notes,
            'order_details': productList
          });
          var header = {
            //if header type is application/json then the data should be in jsonEncode method
            "Accept": "application/json",
            "Content-Type": "application/json"
          };

          var response = await http.post(
            Uri.parse('https://dawnsapps.com/myapi/public/api/order'),
            body: data,
            headers: header,
          );
          if (response.statusCode == 200) {
            var responseData = jsonDecode(response.body);

            //save the order id to local database. will be needed to fetch pending order
            OrderDbService().insertData(responseData['order_id']);
            //after successfull order placement. use this id to fetch ordered products

            //set loading false
            Provider.of<OrderService>(context, listen: false).setLoadingFalse();

            OthersHelper().showToast(
                "Order Placed Successfully", ConstantColors().greenColor);
            setLoadingFalse();

            //bring back the coupon input field
            Provider.of<CouponService>(context, listen: false)
                .setAppliedCouponFalse();

            //go to success page and send product list to generate pdf
            var cartProducts =
                Provider.of<AddtoCartService>(context, listen: false).products;

            //send sms to user and admin phone that an order has been placed
            SmsService().sendSms(phone, responseData['order_id']);
            //send email to admin's phone that new order has been placed
            sendEmail(name, address, responseData['order_id'], cartProducts,
                phone, notes ?? '', context);
            // EmailService().sendMail(responseData['order_id'], cartProducts,
            //     deliveryCharge, grandTotal);

            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => OrderSuccessfulPage(
                  orderedProducts: cartProducts,
                  customerName: name,
                  customerAddress: address,
                  ordernumber: responseData['order_id'] ?? 0,
                  customerPhone: phone,
                  notes: notes,
                  // paymentMethod: paymentMethod,
                ),
              ),
            );

            Future.delayed(const Duration(seconds: 1), () {
              //make cart empty or delete all data from cart table after 1 second because we need
              //to send the data of the cart to next page first to generate invoice
              AddtoCartService().emptyLocalCart(context);
            });

            //then if user wants, try the info of user to register
            if (createAccountforLater == true) {
              SignUpService().register(name, email, password, password, phone,
                  address, createAccountforLater, context);
            }
          } else {
            print(
                "checkout page create account for later error is ${response.body}");
            OthersHelper().showToast(
                "Something went wrong", ConstantColors().primaryColor);
          }
        } else {
          Provider.of<OrderService>(context, listen: false).setLoadingFalse();
          OthersHelper().showToast("You don't have any product in your cart",
              ConstantColors().primaryColor);
        }
      }
    }
  }

  //send email and include pdf function
  sendEmail(customerName, customerAddress, orderNumber, orderedProducts, phone,
      notes, BuildContext context) async {
    final invoice = invoiceLayout(
        customerName, customerAddress, orderNumber, orderedProducts);

    var totalprice =
        Provider.of<ProductService>(context, listen: false).totalPrice;

    var coupon = Provider.of<CouponService>(context, listen: false).coupon;
    final pdfFile = await PdfInvoiceApi.generate(
        invoice, coupon, totalprice, "$orderNumber-invoice", phone, notes);

    EmailService().sendMail(
        orderNumber,
        orderedProducts,
        totalprice >= 500 ? 0 : OthersHelper().deliveryCharge,
        totalprice,
        pdfFile);
  }
}
