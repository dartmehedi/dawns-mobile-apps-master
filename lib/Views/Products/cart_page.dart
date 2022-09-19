import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawnsapp/Models/addtocart_model.dart';
import 'package:dawnsapp/Services/Addtocart/addto_cart_service.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Views/Delivery/checkout_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    //load all products initially
    Provider.of<AddtoCartService>(context, listen: false).getProducts();
  }

  //TODO if user adds same product more than once then increase the quantity
  //TODO show image of added product in cart

  @override
  Widget build(BuildContext context) {
    //getting screen width for responsive issue
    var screenWidth = MediaQuery.of(context).size.width;
    var providerListen = Provider.of<AddtoCartService>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("My cart",
            style: TextStyle(
                color: ConstantColors().greyPrimary,
                fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(
          color: ConstantColors().greyPrimary, //change your color here
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: //Product list ===================>
          Padding(
        padding: EdgeInsets.symmetric(
            vertical: 18, horizontal: screenWidth < 350 ? 10 : 25),
        child: Column(
          children: [
            Expanded(
              child: providerListen.products.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: providerListen.products.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.fromLTRB(0, 2, 10, 2),
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
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: CachedNetworkImage(
                                  imageUrl: providerListen.products[index]
                                              ['productImage'] !=
                                          ""
                                      ? "https://dawnsapps.com/${providerListen.products[index]['productImage']}"
                                      : 'https://cdn.pixabay.com/photo/2018/03/26/14/07/space-3262811_960_720.jpg',
                                  placeholder: (context, url) {
                                    return Image.asset(
                                        'assets/images/placeholder.png');
                                  },
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  height: screenWidth < 350 ? 30 : 50,
                                  width: screenWidth < 350 ? 30 : 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),

                              //product name ===================
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        //product name
                                        Provider.of<AddtoCartService>(context,
                                                listen: true)
                                            .products[index]['productName'],
                                        style: TextStyle(
                                            color: ConstantColors().greyPrimary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      //Product price and offer texts
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                //price
                                                // "৳ ${providerListen.products[index]['totalPrice']}",
                                                "৳ ${providerListen.products[index]['singlePrice']}",
                                                style: TextStyle(
                                                    color: ConstantColors()
                                                        .greyPrimary,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: screenWidth < 350
                                                        ? 14
                                                        : 17),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),

                                              //quantity and unit
                                              providerListen.products[index]
                                                          ['unit'] !=
                                                      ""
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 9,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: ConstantColors()
                                                            .secondaryColor
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Text(
                                                        "${providerListen.products[index]['quantity']} ${providerListen.products[index]['unit']}"
                                                            .toLowerCase(),
                                                        style: TextStyle(
                                                            color: ConstantColors()
                                                                .secondaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                      ),
                                                    )
                                                  : Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 9,
                                                          vertical: 2),
                                                      decoration: BoxDecoration(
                                                        color: ConstantColors()
                                                            .secondaryColor
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Text(
                                                        "${providerListen.products[index]['quantity']}x"
                                                            .toLowerCase(),
                                                        style: TextStyle(
                                                            color: ConstantColors()
                                                                .secondaryColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                              const SizedBox(
                                                width: 9,
                                              ),
                                            ],
                                          ), //quantity and unit section end ==================//

                                          //========== increase decrease button =============//
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                //decrease quantity icon =================
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      AddtoCartService().decreaseQtandPrice(
                                                          Provider.of<AddtoCartService>(
                                                                      context,
                                                                      listen: false)
                                                                  .products[index]
                                                              ['productId'],
                                                          Provider.of<AddtoCartService>(
                                                                      context,
                                                                      listen: false)
                                                                  .products[index]
                                                              ['productName'],
                                                          context);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal:
                                                                  screenWidth <
                                                                          350
                                                                      ? 6
                                                                      : 9),
                                                      child: Icon(
                                                        Icons
                                                            .remove_circle_outline,
                                                        color: ConstantColors()
                                                            .greySecondary,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                //increase quantity button
                                                Material(
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      AddtoCartService().increaseQtandPrice(
                                                          Provider.of<AddtoCartService>(
                                                                      context,
                                                                      listen: false)
                                                                  .products[index]
                                                              ['productId'],
                                                          Provider.of<AddtoCartService>(
                                                                      context,
                                                                      listen: false)
                                                                  .products[index]
                                                              ['productName'],
                                                          1,
                                                          context);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal:
                                                                  screenWidth <
                                                                          350
                                                                      ? 6
                                                                      : 9),
                                                      child: Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        color: ConstantColors()
                                                            .greySecondary,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Material(
                                                  //delete a product
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      Provider.of<AddtoCartService>(
                                                              context,
                                                              listen: false)
                                                          .deleteData(
                                                              Provider.of<AddtoCartService>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .products[index]
                                                                  ['productId'],
                                                              Provider.of<AddtoCartService>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .products[index]
                                                                  [
                                                                  'productName'],
                                                              context);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12,
                                                              horizontal:
                                                                  screenWidth <
                                                                          350
                                                                      ? 6
                                                                      : 9),
                                                      child: Icon(
                                                        Icons
                                                            .delete_outline_sharp,
                                                        color: ConstantColors()
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Text("You don't have any product in cart")),
            ),

            //Proceed to checkout button and total price
            Column(
              children: [
                const SizedBox(
                  height: 7,
                ),
                Text(
                    "${Provider.of<ProductService>(context, listen: true).totalPrice}",
                    style: TextStyle(
                        color: ConstantColors().greyPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 42)),
                const SizedBox(
                  height: 4,
                ),
                Text("Total price (৳)",
                    style: TextStyle(
                        color: ConstantColors().greyPrimary, fontSize: 17)),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    if (Provider.of<ProductService>(context, listen: false)
                            .totalCartProductsNumber !=
                        0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CheckoutPage()));
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color:
                              Provider.of<ProductService>(context, listen: true)
                                          .totalCartProductsNumber !=
                                      0
                                  ? ConstantColors().primaryColor
                                  : ConstantColors().greySecondary,
                          borderRadius: BorderRadius.circular(7)),
                      child: const Text(
                        "Proceed to checkout",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
