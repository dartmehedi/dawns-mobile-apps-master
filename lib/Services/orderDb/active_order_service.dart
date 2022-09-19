import 'dart:convert';

import 'package:dawnsapp/Models/active_order_model.dart';
import 'package:dawnsapp/Services/orderDb/order_db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ActiveOrderService with ChangeNotifier {
  bool isloading = true;
  List dataList = [];
  getDataList() {
    return dataList;
  }

  setDataList(modelData) {
    dataList.add(modelData);
    isloading = false;
    notifyListeners();
    Future.delayed(Duration(milliseconds: 50), () {
      isloading = true;
    });
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  fetchOrder(BuildContext context) async {
    // Provider.of<ActiveOrderService>(context, listen: false).setLoadingTrue();
    print("function ran");
    dataList =
        []; //make the list empty first. otherswise existing data will stay and data will be repeated

    List orderNumbers =
        await OrderDbService().readData(); //fetch order numbers from local data

    if (orderNumbers.isNotEmpty) {
      for (int i = 0; i < orderNumbers.length; i++) {
        var response = await http.get(Uri.parse(
            'https://dawnsapps.com/myapi/public/api/order-details/${orderNumbers[i]["orderId"]}'));

        if (response.statusCode == 200) {
          var decodedData = jsonDecode(response.body);
          if (decodedData["data"].isNotEmpty) {
            print("data not empty");
            //if product list is not empty
            ActiveOrderModel modelData = ActiveOrderModel.fromJson(decodedData);
            // add the data to the list
            setDataList(modelData);
            // Provider.of<ActiveOrderService>(context, listen: false)
            //     .setLoadingFalse();
            // modelData.data[0].orderDetails![0].productName
            // print(dataList[0].data[0].orderDetails![0].productName);
          } else {
            //delete that order number from local data because admin market the order as delivered
            print("data deleted");
            await OrderDbService()
                .deleteData(orderNumbers[i]["id"], orderNumbers[i]["orderId"]);
          }
        } else {
          print(
              "Error in active order list is is ${response.body}"); //return empty list if something went wrong// response code not 200
          isloading = false;
          notifyListeners();
        }
      }
    } else {
      Provider.of<ActiveOrderService>(context, listen: false).setLoadingFalse();
    }

    for (int i = 0; i < dataList.length; i++) {
      print(dataList[i].data[0].orderDetails![0].productName);
    }

    //   if (response.statusCode == 200) {
    //   var decodedData = jsonDecode(response.body);
    //   if (decodedData["data"].isNotEmpty) {
    //     //if product list is not empty
    //     ActiveOrderModel modelData = ActiveOrderModel.fromJson(decodedData);
    //     dataList.add(modelData);
    //     // modelData.data[0].orderDetails![0].productName
    //     print(dataList[0].data[0].orderDetails![0].productName);
    //   } else {
    //     //delete order number from local data
    //   }
    // } else {
    //   return dataList; //return empty list if no data exists
    // }
  }
}
