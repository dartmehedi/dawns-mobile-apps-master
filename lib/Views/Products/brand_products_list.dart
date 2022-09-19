import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawnsapp/Models/brand_products_list_model.dart';
import 'package:dawnsapp/Services/Addtocart/db_service.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Views/Products/product_helper.dart';
import 'package:dawnsapp/Views/Products/single_products_page2.dart';
import 'package:dawnsapp/Views/Search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'cart_page.dart';
import 'package:http/http.dart' as http;

class BrandProductList extends StatefulWidget {
  const BrandProductList({Key? key, this.subBrandName, this.parentId})
      : super(key: key);

  final subBrandName;
  final parentId;

  @override
  State<BrandProductList> createState() => _BrandProductListState();
}

class _BrandProductListState extends State<BrandProductList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int currentPage = 1;

  late int totalPages;

  List? productList = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
//  var parentBrandId = ModalRoute.of(context)!.settings.arguments;

  Future<bool> fetchBrandProductsList(var id, {bool isrefresh = false}) async {
    print("current page is $currentPage");
    if (isrefresh) {
      print("is refresh ran");
      currentPage = 1;
      setState(() {});
    } else {
      if (currentPage > totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    var response = await http.get(Uri.parse(
        'https://dawnsapps.com/myapi/public/api/get_brand_details/$id?page=$currentPage'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var finalData = BrandProductListModel.fromJson(jsonData);

      if (isrefresh) {
        productList = finalData.data;
      } else {
        productList!.addAll(finalData.data!.toList());
      }

      currentPage++;

      totalPages = finalData.lastPage;

      // print(response.body);
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.subBrandName,
          style: TextStyle(color: ConstantColors().greyPrimary),
        ),
        actions: [
          //search icon
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const SearchPage()));
            },
            child: Container(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Icon(
                Icons.search,
                color: cc.greyPrimary,
              ),
            ),
          ),

          //cart page icon
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            child: Container(
                margin: const EdgeInsets.only(right: 25, left: 15),
                alignment: Alignment.center,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      size: 23,
                      color: cc.greyPrimary,
                    ),
                    Positioned(
                        right: -7,
                        top: -10,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: cc.primaryColor),
                          child: Text(
                            "${Provider.of<ProductService>(context, listen: true).totalCartProductsNumber}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                        ))
                  ],
                )),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: ConstantColors().greyPrimary,
        ),
      ),
      body: //Product list ===================>
          Stack(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 15, right: 25, left: 25, bottom: 55),
            child: Row(
              children: [
                Expanded(
                    child: SmartRefresher(
                  controller: refreshController,
                  enablePullUp: true,
                  enablePullDown: currentPage > 1
                      ? false
                      : true, //this trick is helping to fix a bug. enable pull down true is causing a bug
                  onRefresh: () async {
                    print("on refresh raan");
                    final result = await fetchBrandProductsList(widget.parentId,
                        isrefresh: true);
                    if (result) {
                      refreshController.refreshCompleted();
                    } else {
                      refreshController.refreshFailed();
                    }
                  },
                  onLoading: () async {
                    final result =
                        await fetchBrandProductsList(widget.parentId);
                    if (result) {
                      refreshController.loadComplete();
                    } else {
                      refreshController.loadNoData();
                    }
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: productList!.length,
                    itemBuilder: (context, index) {
                      // removing fractional value from double and then converting that value to integer
                      var discountAfterMakingInt = int.parse(
                          double.parse(productList![index].discountPrice)
                              .toStringAsFixed(0));
                      var discountPrice = discountAfterMakingInt > 0
                          ? discountAfterMakingInt
                          : 0;
                      var sellingPrice = int.parse(
                          double.parse(productList![index].sellingPrice)
                              .toStringAsFixed(0));

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SingleProductPageTwo(
                                        data: productList![index],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.06),
                                spreadRadius: 0,
                                blurRadius: 8,
                                offset: const Offset(1, 0),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //product image left sided
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: CachedNetworkImage(
                                  imageUrl: productList![index].defaultImage !=
                                          null
                                      ? "https://dawnsapps.com/${productList![index].defaultImage}"
                                      : 'https://cdn.pixabay.com/photo/2018/03/26/14/07/space-3262811_960_720.jpg',
                                  placeholder: (context, url) {
                                    return Image.asset(
                                        'assets/images/placeholder.png');
                                  },
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 14,
                              ),

                              //product name and price and kg ===================
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      //product name / title
                                      productList![index].productName ??
                                          'no data',
                                      style: TextStyle(
                                          color: ConstantColors().greyPrimary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    //Product price and offer texts
                                    Row(
                                      children: [
                                        //present selling price/ if there is discount then the discount price is our current selling price
                                        Text(
                                          "৳ ${discountPrice > 0 ? discountPrice : sellingPrice}",
                                          style: TextStyle(
                                              color:
                                                  ConstantColors().primaryColor,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        ),

                                        const SizedBox(
                                          width: 8,
                                        ),
                                        // previous selling price ======>
                                        discountPrice > 0
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  "৳ $sellingPrice",
                                                  style: TextStyle(
                                                      color: ConstantColors()
                                                          .greySecondary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                              )
                                            : Container(),
                                        productList![index].unit != null
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 9,
                                                        vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: ConstantColors()
                                                      .secondaryColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Text(
                                                  //unit

                                                  "1 " +
                                                      "${productList![index].unit}"
                                                          .toLowerCase(),
                                                  style: TextStyle(
                                                      color: ConstantColors()
                                                          .secondaryColor,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              //==========Product name and price and kg section end=============//

                              //add to cart icon =================
                              productList![index].productQuantity != null
                                  ? productList![index].productQuantity != '0'
                                      ? Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            onTap: () {
                                              DbService().insertData(
                                                  productList![index].id,
                                                  productList![index]
                                                      .productName,
                                                  productList![index]
                                                      .defaultImage,
                                                  //present selling price
                                                  discountPrice > 0
                                                      ? discountPrice
                                                      : sellingPrice,
                                                  1,
                                                  context,
                                                  productList![index].unit);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 17,
                                                      horizontal: 17),
                                              child: Icon(
                                                Icons.add_circle_outline,
                                                color: ConstantColors()
                                                    .greySecondary,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container()
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
              ],
            ),
          ),

          // Place order container
          ProductHelper().placeOrderBottomSection(context),
        ],
      ),
    );
  }
}
