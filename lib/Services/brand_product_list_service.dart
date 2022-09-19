// import 'dart:convert';

// import 'package:dawnsapp/Models/brand_products_list_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;

// class BrandProductListService with ChangeNotifier {
//   List<BrandProductList>? productList = [];
//   int currentPage = 1;
//   late int totalpage;
//   Future<bool> fetchBrandProductsList(var id, refreshController,
//       {bool isrefresh = false}) async {
//     print("function ran");
//     var response = await http.get(Uri.parse(
//         'https://dawnsapps.com/myapi/public/api/get_brand_details/$id?page=1'));
//     if (response.statusCode == 200) {
//       var jsonData = jsonDecode(response.body);

//       var finalData = BrandProductListModel.fromJson(jsonData);
//       // if (isrefresh) {
//       //   productList = finalData.data;
//       //   notifyListeners();
//       // } else {
//       //   productList!.addAll(finalData.data!.toList());
//       //   notifyListeners();
//       // }
//       productList = finalData.data;
//       productList!.addAll(finalData.data!.toList());
//       notifyListeners();

//       currentPage++;
//       // totalpage = finalData.lastPage ?? 0;
//       // if (isrefresh) {
//       //   currentPage = 1;
//       // } else {
//       //   if (currentPage >= totalpage) {
//       //     refreshController.loadNoData();
//       //     return false;
//       //   }
//       // }

//       // print(productList![0].productName);
//       return true;
//     } else {
//       // return Future.value(null);
//       // ignore: avoid_print
//       print('errr');
//       // ignore: null_argument_to_non_null_type
//       // return Future.value(null);
//       return false;
//     }
//   }
// }
