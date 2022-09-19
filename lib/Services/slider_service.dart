import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dawnsapp/Models/slider_model.dart';
import 'package:http/http.dart' as http;

class SliderService {
  Future<List> fetchSlider() async {
    var sliderList = [];
    var response = await http
        .get(Uri.parse('https://dawnsapps.com/myapi/public/api/slider'));

    if (response.statusCode == 200) {
      var finalData = SliderModel.fromJson(jsonDecode(response.body));
      sliderList
        ..add(finalData.data[0].slider1)
        ..add(finalData.data[0].slider2)
        ..add(finalData.data[0].slider3);
      return sliderList;
    } else {
      return [];
    }
  }
}
