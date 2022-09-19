import 'dart:convert';

import 'package:dawnsapp/Models/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SearchService with ChangeNotifier {
  List<ProductList> productslist = [];
  bool isLoading = false;

  getLoading() {
    return isLoading;
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  Future fetchProduct(String searchString) async {
    var response = await http.get(Uri.parse(
        'https://dawnsapps.com/myapi/public/api/search/$searchString'));
    if (response.statusCode == 200) {
      var finaldata = SearchModel.fromJson(jsonDecode(response.body));
      productslist = finaldata.data;
      isLoading = false;
      notifyListeners();
    } else {
      print("errrrrror");
    }
  }
}
