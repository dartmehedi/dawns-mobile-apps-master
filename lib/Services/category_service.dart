import 'dart:convert';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:http/http.dart' as http;
import 'package:dawnsapp/Models/category_model.dart';
import 'package:api_cache_manager/api_cache_manager.dart';

class CategoryService {
  List<CategoryModel> parseOutWork(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<CategoryModel>((json) => CategoryModel.fromJson(json))
        .toList();
  }

  Future<List<CategoryModel>> fetchCategory() async {
    var isCacheExist =
        await APICacheManager().isAPICacheKeyExist("drawerMenuCache");
    if (!isCacheExist) {
      var response = await http
          .get(Uri.parse('https://dawnsapps.com/myapi/public/api/getmenu'));

      if (response.statusCode == 200) {
        // save data in cache
        APICacheDBModel cacheDBModel =
            APICacheDBModel(key: "drawerMenuCache", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);
        return parseOutWork(response.body);
      } else {
        print("errorrrrr");
        return Future.value(null);
      }
    } else {
      //load from cache
      var cacheData = await APICacheManager().getCacheData("drawerMenuCache");
      return parseOutWork(cacheData.syncData);
    }
  }
}
