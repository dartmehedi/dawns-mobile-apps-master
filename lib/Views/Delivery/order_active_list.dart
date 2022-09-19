import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/orderDb/active_order_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderActiveList extends StatefulWidget {
  const OrderActiveList({Key? key}) : super(key: key);

  @override
  State<OrderActiveList> createState() => _OrderActiveListState();
}

class _OrderActiveListState extends State<OrderActiveList> {
  @override
  void initState() {
    super.initState();
    Provider.of<ActiveOrderService>(context, listen: false).fetchOrder(context);
  }

  @override
  Widget build(BuildContext context) {
    var providerListen = Provider.of<ActiveOrderService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("My orders",
            style: TextStyle(
                color: ConstantColors().greyPrimary,
                fontWeight: FontWeight.w600)),
        iconTheme: IconThemeData(
          color: ConstantColors().greyPrimary, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            providerListen.isloading == false
                ? Expanded(
                    child: providerListen.dataList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: providerListen.getDataList().length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: ConstantColors().primaryColor,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Text(
                                      "Order ID: ${providerListen.dataList[index].data[0].id}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  for (int i = 0;
                                      i <
                                          providerListen.dataList[index].data[0]
                                              .orderDetails.length;
                                      i++)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.grey.withOpacity(0.03),
                                            spreadRadius: 0,
                                            blurRadius: 8,
                                            offset: const Offset(1, 0),
                                          ),
                                        ],
                                      ),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: Row(
                                        children: [
                                          //image
                                          Container(
                                            margin: const EdgeInsets.only(
                                                right: 15),
                                            child: CachedNetworkImage(
                                              imageUrl: providerListen
                                                          .dataList[index]
                                                          .data[0]
                                                          .orderDetails![i]
                                                          .productImage !=
                                                      null
                                                  ? "https://dawnsapps.com/${providerListen.dataList[index].data[0].orderDetails![i].productImage}"
                                                  : 'https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d2hpdGV8ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
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
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${providerListen.dataList[index].data[0].orderDetails![i].productName}",
                                                  style: TextStyle(
                                                      color: ConstantColors()
                                                          .greyPrimary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 15),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Quantity: ${providerListen.dataList[index].data[0].orderDetails![i].qty}",
                                                      style: TextStyle(
                                                          color:
                                                              ConstantColors()
                                                                  .greyPrimary,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15),
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Text(
                                                      "Price: ${providerListen.dataList[index].data[0].orderDetails![i].singleprice} ৳",
                                                      style: TextStyle(
                                                        color: ConstantColors()
                                                            .greyPrimary,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  //grand total card
                                  Container(
                                    color: Colors.white,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 13),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Coupon discount:",
                                              style: TextStyle(
                                                  color: ConstantColors()
                                                      .greySecondary,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "${providerListen.dataList[index].data[0].couponDiscount}",
                                              style: TextStyle(
                                                  color: ConstantColors()
                                                      .greySecondary,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Delivery charge:",
                                              style: TextStyle(
                                                  color: ConstantColors()
                                                      .greySecondary,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "${providerListen.dataList[index].data[0].shippingCharge}",
                                              style: TextStyle(
                                                  color: ConstantColors()
                                                      .greySecondary,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 2,
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Grand Total:",
                                              style: TextStyle(
                                                  color: ConstantColors()
                                                      .greySecondary,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              "৳ ${providerListen.dataList[index].data[0].total}",
                                              style: TextStyle(
                                                  color: ConstantColors()
                                                      .primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),

                                  // Text(
                                  //   "If you have any query. Please contact us:",
                                  //   style: TextStyle(
                                  //       fontSize: 16,
                                  //       color: ConstantColors().greyPrimary),
                                  // ),
                                ],
                              );
                            },
                          )
                        : const Center(
                            child: Text("You don't have any active order")),
                  )
                : Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 20),
                    child: SpinKitThreeBounce(
                      color: ConstantColors().primaryColor,
                      size: 20.0,
                    ),
                  ),
            //report problem button
            const SizedBox(
              height: 18,
            ),
            InkWell(
              onTap: () {
                launch("mailto:info@dawn-stationery.com");
              },
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: ConstantColors().greenColor,
                      borderRadius: BorderRadius.circular(3)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.mail,
                        size: 21,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Report a problem",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 21,
            ),
          ],
        ),
      ),
    );
  }
}
