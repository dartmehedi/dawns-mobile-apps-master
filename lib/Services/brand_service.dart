import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dawnsapp/Models/brandlist_model.dart';
import 'package:http/http.dart' as http;

class BrandService {
  // List<BrandListModel> parseOutWork(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed
  //       .map<BrandListModel>((json) => BrandListModel.fromJson(json))
  //       .toList();
  // }

  Future<List> fetchBrandList() async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("brandListCache");

    if (!isCacheExist) {
      var response = await http
          .get(Uri.parse('https://dawnsapps.com/myapi/public/api/getbrands'))
          .catchError((error) {});

      if (response.statusCode == 200) {
        // save data in cache
        APICacheDBModel cacheDBModel =
            APICacheDBModel(key: "brandListCache", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);

        var data = jsonDecode(response.body);
        List list = [];
        for (int i = 0; i < data.length; i++) {
          var a = BrandListModel.fromJson(data[i][0]);
          list.add(a);
        }
        return list;

        // return parseOutWork(a);
      } else {
        print("errorrrrr");
        return [];
      }
    } else {
      //load from cache
      var cacheData = await APICacheManager().getCacheData("brandListCache");
      var data = jsonDecode(cacheData.syncData);
      List list = [];
      for (int i = 0; i < data.length; i++) {
        var a = BrandListModel.fromJson(data[i][0]);
        list.add(a);
      }
      return list;
    }
  }
}
