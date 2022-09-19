import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:dawnsapp/Models/sub_categories_drawer_model.dart';
import 'package:http/http.dart' as http;

class SubCategoriesDrawerService {
  Future<SubCategoryDrawerModel> fetchSubCategoryDrawer(int parentId) async {
    var isCacheExist = await APICacheManager()
        .isAPICacheKeyExist("subCategory_drawer$parentId");

    if (!isCacheExist) {
      var response = await http.get(Uri.parse(
          'https://dawnsapps.com/myapi/public/api/get-sub-categories/$parentId'));
      if (response.statusCode == 200) {
        // save data in cache
        APICacheDBModel cacheDBModel = APICacheDBModel(
            key: "subCategory_drawer$parentId", syncData: response.body);
        await APICacheManager().addCacheData(cacheDBModel);

        var jsonData = jsonDecode(response.body);
        var finalData = SubCategoryDrawerModel.fromJson(jsonData);
        return finalData;
      } else {
        return Future.value(null);
      }
    } else {
      //load from cache
      var cacheData =
          await APICacheManager().getCacheData("subCategory_drawer$parentId");
      var jsonData = jsonDecode(cacheData.syncData);
      var finalData = SubCategoryDrawerModel.fromJson(jsonData);
      return finalData;
    }
  }
}
