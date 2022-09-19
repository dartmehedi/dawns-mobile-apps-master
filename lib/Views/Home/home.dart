import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawnsapp/Models/home_productlist_model.dart';
import 'package:dawnsapp/Services/Addtocart/db_service.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/brand_service.dart';
import 'package:dawnsapp/Services/local_notification_service.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Services/user_service.dart';
import 'package:dawnsapp/Views/Home/homepage_helper.dart';
import 'package:dawnsapp/Views/Others/drawer.dart';
import 'package:dawnsapp/Views/Products/brand_products_list.dart';
import 'package:dawnsapp/Views/Products/cart_page.dart';
import 'package:dawnsapp/Views/Products/product_helper.dart';
import 'package:dawnsapp/Views/Products/single_product.dart';
import 'package:dawnsapp/Views/Products/single_products_page2.dart';
import 'package:dawnsapp/Views/Search/search_page.dart';
import 'package:dawnsapp/Views/notification/notification_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_version/new_version.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConstantColors cc = ConstantColors();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchTextController = TextEditingController();

  //product list stuff
  int currentPage = 1;

  late int totalPages;

  List productList = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> fetchBrandProductsList({bool isrefresh = false}) async {
    if (isrefresh) {
      currentPage = 1;
    } else {
      if (currentPage > totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    var response = await http
        .get(Uri.parse(
            'https://dawnsapps.com/myapi/public/api/getproducts?page=$currentPage'))
        .catchError((error) {
      print("home screen error is $error");
    });

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      var finalData = HomeProductlistModel.fromJson(jsonData);

      if (isrefresh) {
        productList = finalData.data;
      } else {
        productList.addAll(finalData.data);
      }

      currentPage++;

      totalPages = finalData.lastPage;

      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    final newVersion = NewVersion(
      iOSId: 'com.dawn.stationary',
      androidId: 'com.dawn.stationary',
    );

    updatealert(newVersion);

    //local notification
    LocalNotificationService().initialize(context);

    ///gives you the message on which user taps
    ///and it opened the app from terminated state //opened when app was completely closed
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NotificationPage(
                      title: message.notification?.title,
                      desc: message.notification?.body,
                      imageLink: message.data.isNotEmpty
                          ? message.data["imageLink"]
                          : null,
                    )));
      }
    });

    ///when app is opened then this function gets called
    FirebaseMessaging.onMessage.listen((message) {
      Provider.of<LocalNotificationValues>(context, listen: false).setValues(
          message.notification?.title,
          message.notification?.body,
          message.data.isNotEmpty ? message.data["imageLink"] : null);

      LocalNotificationService().display(message, context);
    });

    ///When the app is in minimized and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(
          "on message opened app ran"); //message.data["route"] ->additional data
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NotificationPage(
                    title: message.notification?.title,
                    desc: message.notification?.body,
                    imageLink: message.data.isNotEmpty
                        ? message.data["imageLink"]
                        : null,
                  )));
    });

    Provider.of<ProductService>(context, listen: false)
        .calculateTotalPrice(); // this will show total price in homepage bottom layer

    loadUserData(); //get user details
  }

  updatealert(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      if (status.storeVersion != status.localVersion) {
        HomepageHelper().updateAlert(context);
      }
    }
  }

  loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var tokenType = prefs.getString("tokenType");
    if (token != null && tokenType != null) {
      Provider.of<UserService>(context, listen: false)
          .getUserDetails(token, tokenType, context);
    }
  }

// when pull down to refresh is getting called page is called.
//then new data not loading again. so  try to turn of pull down to refresh
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      appBar: AppBar(
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
          leading: InkWell(
              onTap: () {
                _scaffoldKey.currentState!.openDrawer();
              },
              child: Icon(
                Icons.menu,
                color: cc.greyPrimary,
              ))),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            child: SmartRefresher(
              controller: refreshController,
              enablePullUp: true,
              enablePullDown: currentPage > 1 ? false : true,
              onRefresh: () async {
                final result = await fetchBrandProductsList(isrefresh: true);
                if (result) {
                  refreshController.refreshCompleted();
                } else {
                  refreshController.refreshFailed();
                }
              },
              onLoading: () async {
                final result = await fetchBrandProductsList();
                if (result) {
                  refreshController.loadComplete();
                } else {
                  refreshController.loadNoData();
                }
              },
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Column(
                    children: [
                      //Top slider ===================>
                      HomepageHelper().topSlider(150, Colors.white),

                      //top brand categories ==== ========
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 144,
                        child: FutureBuilder<List>(
                          future: BrandService().fetchBrandList(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    for (int i = 0;
                                        i < snapshot.data!.length;
                                        i++)
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BrandProductList(
                                                        subBrandName: snapshot
                                                            .data?[i].brandName,
                                                        parentId: snapshot
                                                            .data![i].id,
                                                      ),
                                                  settings: RouteSettings(
                                                      arguments: snapshot
                                                          .data![i].id)));
                                        },
                                        child: Container(
                                            alignment: Alignment.bottomCenter,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            width: 100,
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 8),
                                                  height: 100,
                                                  width: 100,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: CachedNetworkImage(
                                                      imageUrl: HomepageHelper()
                                                              .getImage(
                                                                  i,
                                                                  snapshot.data![
                                                                      i]) ??
                                                          'https://cdn.pixabay.com/photo/2018/03/26/14/07/space-3262811_960_720.jpg',
                                                      // placeholder:
                                                      //     (context, url) {
                                                      //   return Image.asset(
                                                      //       'assets/images/placeholder.png');
                                                      // },
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Icon(
                                                              Icons.error),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  //brand name
                                                  margin: const EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      bottom: 8,
                                                      top: 3),
                                                  child: Text(
                                                    snapshot.data?[i]
                                                            .brandName ??
                                                        'no data',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: ConstantColors()
                                                            .greyPrimary,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )
                                  ]);
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return const Center(
                                child: Text("Server error or no data found"),
                              );
                            } else {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: SpinKitThreeBounce(
                                        color: ConstantColors().primaryColor,
                                        size: 25.0,
                                      )),
                                ],
                              );
                            }
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //Product list ===================>
                      Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: productList.length,
                              itemBuilder: (context, index) {
                                // removing fractional value from double and then converting that value to integer
                                var discountAfterMakingInt = int.parse(
                                    double.parse(
                                            productList[index].discountPrice)
                                        .toStringAsFixed(0));
                                var discountPrice = discountAfterMakingInt > 0
                                    ? discountAfterMakingInt
                                    : 0;
                                var sellingPrice = int.parse(double.parse(
                                        productList[index].sellingPrice)
                                    .toStringAsFixed(0));

                                return InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SingleProductPageTwo(
                                                  data: productList[index],
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //product image left sided
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: CachedNetworkImage(
                                            imageUrl: productList[index]
                                                        .defaultImage !=
                                                    null
                                                ? "https://dawnsapps.com/${productList[index].defaultImage}"
                                                : 'https://cdn.pixabay.com/photo/2018/03/26/14/07/space-3262811_960_720.jpg',
                                            placeholder: (context, url) {
                                              return Image.asset(
                                                  'assets/images/placeholder.png');
                                            },
                                            errorWidget:
                                                (context, url, error) =>
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                productList[index]
                                                        .productName ??
                                                    '0',
                                                style: TextStyle(
                                                    color: ConstantColors()
                                                        .greyPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              const SizedBox(
                                                height: 9,
                                              ),
                                              //Product price and offer texts
                                              Row(
                                                children: [
                                                  //present selling price/ if there is discount then the discount price is our current selling price
                                                  Text(
                                                    "৳ ${discountPrice > 0 ? discountPrice : sellingPrice}",
                                                    style: TextStyle(
                                                        color: ConstantColors()
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  ),

                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  // previous selling price ======>
                                                  discountPrice > 0
                                                      ? Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 10),
                                                          child: Text(
                                                            "৳ $sellingPrice",
                                                            style: TextStyle(
                                                                color: ConstantColors()
                                                                    .greySecondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14,
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough),
                                                          ),
                                                        )
                                                      : Container(),
                                                  productList[index].unit !=
                                                          null
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal: 9,
                                                                  vertical: 2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ConstantColors()
                                                                .secondaryColor
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                          ),
                                                          child: Text(
                                                            "1 ${productList[index].unit}"
                                                                .toLowerCase(),
                                                            style: TextStyle(
                                                                color: ConstantColors()
                                                                    .secondaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
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
                                        productList[index].productQuantity !=
                                                null
                                            ? productList[index]
                                                        .productQuantity !=
                                                    '0'
                                                ? Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {
                                                        DbService().insertData(
                                                            productList[index]
                                                                .id,
                                                            productList[index]
                                                                .productName,
                                                            productList[index]
                                                                .defaultImage,
                                                            //present selling price
                                                            discountPrice > 0
                                                                ? discountPrice
                                                                : sellingPrice,
                                                            1,
                                                            context,
                                                            productList[index]
                                                                    .unit ??
                                                                "");
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 17,
                                                                horizontal: 17),
                                                        child: Icon(
                                                          Icons
                                                              .add_circle_outline,
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
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Place order container
          ProductHelper().placeOrderBottomSection(context),
        ],
      ),
    );
  }
}
