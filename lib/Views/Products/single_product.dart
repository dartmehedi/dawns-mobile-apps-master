import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawnsapp/Services/Addtocart/db_service.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Services/single_product_service.dart';
import 'package:dawnsapp/Views/Home/homepage_helper.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/image_render.dart';
import 'package:provider/provider.dart';

import 'cart_page.dart';

class SingleProduct extends StatefulWidget {
  const SingleProduct({
    Key? key,
    this.data,
  }) : super(key: key);

  final data;

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  int _selectedSlide = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProductService>(context, listen: false)
        .checkIfAlreadyAddedToCart(widget.data.id, widget.data.productName);
  }

  @override
  Widget build(BuildContext context) {
    final singleproductProvider = Provider.of<SingleProductService>(context);
    final providerListen =
        Provider.of<SingleProductService>(context, listen: true);

    // removing fractional value from double and then converting that value to integer
    var discountAfterMakingInt =
        int.parse(double.parse(widget.data.discountPrice).toStringAsFixed(0));
    var discountPrice = discountAfterMakingInt > 0 ? discountAfterMakingInt : 0;
    var sellingPrice =
        int.parse(double.parse(widget.data.sellingPrice).toStringAsFixed(0));
    return WillPopScope(
      onWillPop: () async {
        singleproductProvider
            .resetCount(); //reset the quantity to zero when user leaves the page
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ConstantColors().greyPrimary),
          actions: [
            //cart page icon
            InkWell(
              onTap: () {
                singleproductProvider
                    .resetCount(); //reset the quantity to zero when user leaves the page
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
                        color: ConstantColors().greyPrimary,
                      ),
                      Positioned(
                          right: -7,
                          top: -10,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: ConstantColors().primaryColor),
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
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // slider
                    Stack(
                      children: [
                        SizedBox(
                          height: 280,
                          child: PageView(
                            onPageChanged: (value) {
                              setState(() {
                                _selectedSlide = value;
                              });
                            },
                            children: [
                              for (int i = 0; i < 1; i++)
                                // widget.data?.defaultImage != null
                                //     ?
                                widget.data.defaultImage != null
                                    ? CachedNetworkImage(
                                        imageUrl: widget.data.defaultImage !=
                                                null
                                            ? "https://dawnsapps.com/${widget.data.defaultImage}"
                                            : 'https://cdn.pixabay.com/photo/2018/03/26/14/07/space-3262811_960_720.jpg',
                                        placeholder: (context, url) {
                                          return Image.asset(
                                              'assets/images/placeholder.png');
                                        },
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        // fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/placeholder.png'),
                              // : Image.asset('assets/images/placeholder.png')
                            ],
                          ),
                        ),

                        //slider count show
                        Positioned(
                          bottom: 20,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (var i = 0; i < 1; i++)
                                AnimatedContainer(
                                  //slider dot /pagination
                                  duration: const Duration(milliseconds: 450),
                                  curve: Curves.easeOutCubic,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: _selectedSlide == i
                                        ? Colors
                                            .transparent // change color here to see active dot color
                                        : Colors.grey[200],
                                  ),
                                  width: _selectedSlide == i ? 15 : 6,
                                  height: 7,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                )
                            ],
                          ),
                        ),

                        //back button on slider
                        // Positioned(
                        //     // top: 40,
                        //     top: 4,
                        //     left: 25,
                        //     child: InkWell(
                        //       onTap: () {
                        //         Navigator.pop(context);
                        //       },
                        //       child: Container(
                        //           padding: const EdgeInsets.all(8),
                        //           decoration: const BoxDecoration(
                        //               color: Colors.white,
                        //               shape: BoxShape.circle),
                        //           child: Icon(Icons.arrow_back,
                        //               color: ConstantColors().greyPrimary)),
                        //     )),
                      ],
                    ),

                    //Name & price
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, top: 10, right: 25, bottom: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            //title
                            widget.data.productName,
                            // "Product name",
                            style: TextStyle(
                                height: 1.5,
                                fontSize: 25,
                                color: ConstantColors().greyPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          //Previous price
                          discountPrice > 0
                              ? Text(
                                  "৳ $sellingPrice",

                                  // "1000",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: ConstantColors().greySecondary,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough),
                                )
                              : Container(),
                          const SizedBox(
                            height: 3,
                          ),
                          //price
                          Row(
                            children: [
                              Text(
                                //price
                                "৳ ${discountPrice > 0 ? discountPrice : sellingPrice}",
                                // "1000",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: ConstantColors().primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              // unit
                              Text(
                                widget.data.unit != null
                                    ? "  (per ${HomepageHelper().converUnit(widget.data.unit.toString()).toLowerCase()})"
                                    : " ",
                                style: TextStyle(
                                    height: .4,
                                    fontSize: 22,
                                    color: ConstantColors().greyPrimary,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),

                          const Divider(
                            height: 25,
                            thickness: .7,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          //product desc
                          Html(
                            data: """</div>
                            ${widget.data.productDescription ?? " "}
                          </div> """,
                            style: {
                              "table": Style(
                                backgroundColor:
                                    Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                              ),
                              "tr": Style(
                                border: Border(
                                    bottom: BorderSide(color: Colors.grey)),
                              ),
                              "th": Style(
                                padding: EdgeInsets.all(6),
                                backgroundColor: Colors.grey,
                              ),
                              "td": Style(
                                padding: EdgeInsets.all(6),
                                alignment: Alignment.topLeft,
                              ),
                              'h5': Style(
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis),
                            },
                            customRender: {
                              "table": (context, child) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: (context.tree as TableLayoutElement)
                                      .toWidget(context),
                                );
                              },
                              "bird": (RenderContext context, Widget child) {
                                return TextSpan(text: "🐦");
                              },
                              "flutter": (RenderContext context, Widget child) {
                                return FlutterLogo(
                                  style: (context.tree.element!
                                              .attributes['horizontal'] !=
                                          null)
                                      ? FlutterLogoStyle.horizontal
                                      : FlutterLogoStyle.markOnly,
                                  textColor: context.style.color!,
                                  size: context.style.fontSize!.size! * 5,
                                );
                              },
                            },
                            customImageRenders: {
                              networkSourceMatcher(domains: ["flutter.dev"]):
                                  (context, attributes, element) {
                                return FlutterLogo(size: 36);
                              },
                              networkSourceMatcher(domains: ["mydomain.com"]):
                                  networkImageRender(
                                headers: {"Custom-Header": "some-value"},
                                altWidget: (alt) => Text(alt ?? ""),
                                loadingWidget: () => Text("Loading..."),
                              ),
                              // On relative paths starting with /wiki, prefix with a base url
                              (attr, _) =>
                                  attr["src"] != null &&
                                  attr["src"]!
                                      .startsWith("/wiki"): networkImageRender(
                                  mapUrl: (url) =>
                                      "https://upload.wikimedia.org" + url!),
                              // Custom placeholder image for broken links
                              networkSourceMatcher(): networkImageRender(
                                  altWidget: (_) => FlutterLogo()),
                            },
                            onLinkTap: (url, _, __, ___) {
                              print("Opening $url...");
                            },
                            onImageTap: (src, _, __, ___) {
                              print(src);
                            },
                            onImageError: (exception, stackTrace) {
                              print(exception);
                            },
                            onCssParseError: (css, messages) {
                              print("css that errored: $css");
                              print("error messages:");
                              messages.forEach((element) {
                                print(element);
                              });
                            },
                          ),

                          //Quantity increase/ decrease button
                          Provider.of<ProductService>(context, listen: true)
                                      .alreadyAdded ==
                                  false
                              //if product already added to cart then don't show increase decrease button
                              ? Row(
                                  children: [
                                    //decrease button ===================
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        singleproductProvider.decreaseCount();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: ConstantColors()
                                                    .greyPrimary)),
                                        child: Text(
                                          "-",
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  ConstantColors().greyPrimary),
                                        ),
                                      ),
                                    ),

                                    //Quantity
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "${providerListen.getCount()}",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                ConstantColors().greyPrimary),
                                      ),
                                    ),

                                    //increase button ===================
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        singleproductProvider.incraseCount();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(14),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: ConstantColors()
                                                    .greyPrimary)),
                                        child: Text(
                                          "+",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  ConstantColors().greyPrimary),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : Container(),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // // Place order container
            // ProductHelper().placeOrderBottomSection(context),
            //Add to cart button

            InkWell(
              onTap: () {
                if (widget.data.productQuantity != null &&
                    widget.data.productQuantity != '0') {
                  if (Provider.of<ProductService>(context, listen: false)
                          .alreadyAdded ==
                      false) {
                    DbService().insertData(
                        widget.data.id,
                        widget.data.productName,
                        widget.data.defaultImage,
                        int.parse(
                          widget.data.sellingPrice,
                        ),
                        providerListen.getCount(),
                        context,
                        widget.data.unit != null
                            ? HomepageHelper()
                                .converUnit(widget.data.unit.toString())
                            : widget.data.unit);
                  } else {
                    OthersHelper()
                        .toastShort("Already added to cart.", Colors.black);
                  }
                }
              },
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 17),
                  decoration: BoxDecoration(
                      color: widget.data.productQuantity != null
                          ? widget.data.productQuantity != '0'
                              ? Provider.of<ProductService>(context,
                                              listen: true)
                                          .alreadyAdded ==
                                      false
                                  ? ConstantColors().primaryColor
                                  : ConstantColors().greenColor
                              : ConstantColors().secondaryColor
                          : ConstantColors().secondaryColor
                      // borderRadius: BorderRadius.circular(7)
                      ),
                  child: Text(
                    widget.data.productQuantity != null
                        ? widget.data.productQuantity != '0'
                            ? Provider.of<ProductService>(context, listen: true)
                                        .alreadyAdded ==
                                    false
                                ? "Add to cart"
                                : "Added to cart"
                            : "Out of stock"
                        : "Out of stock",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
