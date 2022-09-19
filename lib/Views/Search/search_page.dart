import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawnsapp/Services/Addtocart/db_service.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/search_service.dart';
import 'package:dawnsapp/Views/Home/homepage_helper.dart';
import 'package:dawnsapp/Views/Products/single_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerListen = Provider.of<SearchService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
          // The search area here
          backgroundColor: ConstantColors().primaryColor,
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                controller: _controller,
                autofocus: true,
                onChanged: (value) {
                  Provider.of<SearchService>(context, listen: false)
                      .setLoadingTrue();
                  Provider.of<SearchService>(context, listen: false)
                      .fetchProduct(value);
                },
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    Provider.of<SearchService>(context, listen: false)
                        .setLoadingTrue();
                    Provider.of<SearchService>(context, listen: false)
                        .fetchProduct(value);
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: ConstantColors().greyPrimary,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: ConstantColors().greyPrimary,
                      ),
                      onPressed: () {
                        setState(() {
                          _controller.clear();
                        });
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
      body: //Product list ===================>
          providerListen.getLoading() != true
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  child: providerListen.productslist.isNotEmpty
                      ? Row(
                          children: [
                            Expanded(
                                child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: providerListen.productslist.length,
                              itemBuilder: (context, index) {
                                // removing fractional value from double and then converting that value to integer
                                var discountAfterMakingInt = int.parse(
                                    double.parse(providerListen
                                            .productslist[index].discountPrice)
                                        .toStringAsFixed(0));
                                var discountPrice = discountAfterMakingInt > 0
                                    ? discountAfterMakingInt
                                    : 0;
                                var sellingPrice = int.parse(double.parse(
                                        providerListen.productslist[index]
                                                .sellingPrice ??
                                            '0')
                                    .toStringAsFixed(0));
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SingleProduct(
                                                  data: providerListen
                                                      .productslist[index],
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
                                            imageUrl: Provider.of<
                                                                SearchService>(
                                                            context,
                                                            listen: true)
                                                        .productslist[index]
                                                        .defaultImage !=
                                                    null
                                                ? "https://dawnsapps.com/${providerListen.productslist[index].defaultImage}"
                                                : 'https://cdn.pixabay.com/photo/2018/03/26/14/07/space-3262811_960_720.jpg',
                                            placeholder: (context, url) {
                                              return Image.asset(
                                                  'assets/images/placeholder.png');
                                            },
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
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
                                                //product name / title
                                                providerListen
                                                        .productslist[index]
                                                        .productName ??
                                                    'no data',
                                                style: TextStyle(
                                                    color: ConstantColors()
                                                        .greyPrimary,
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
                                                  providerListen
                                                              .productslist[
                                                                  index]
                                                              .unit !=
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
                                                            //unit

                                                            "1 " +
                                                                "${HomepageHelper().converUnit(providerListen.productslist[index].unit.toString().toLowerCase())}",
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
                                        providerListen.productslist[index]
                                                    .productQuantity !=
                                                null
                                            ? providerListen.productslist[index]
                                                        .productQuantity !=
                                                    '0'
                                                ? Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {
                                                        DbService().insertData(
                                                            providerListen
                                                                .productslist[
                                                                    index]
                                                                .id,
                                                            providerListen
                                                                    .productslist[
                                                                        index]
                                                                    .productName ??
                                                                "no name",
                                                            providerListen
                                                                    .productslist[
                                                                        index]
                                                                    .defaultImage ??
                                                                " ",
                                                            discountPrice > 0
                                                                ? discountPrice
                                                                : sellingPrice,
                                                            1, //1 is default quantity
                                                            context,
                                                            providerListen
                                                                        .productslist[
                                                                            index]
                                                                        .unit !=
                                                                    null
                                                                ? HomepageHelper().converUnit(
                                                                    providerListen
                                                                        .productslist[
                                                                            index]
                                                                        .unit
                                                                        .toString())
                                                                : "");
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
                            ))
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("no data found"),
                            ),
                          ],
                        ))
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 40),
                        height: 40,
                        width: 40,
                        child: SpinKitThreeBounce(
                          color: ConstantColors().primaryColor,
                          size: 25.0,
                        )),
                  ],
                ),
    );
  }
}
