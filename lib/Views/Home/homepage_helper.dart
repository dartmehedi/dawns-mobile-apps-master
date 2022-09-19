import 'package:cached_network_image/cached_network_image.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/slider_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

class HomepageHelper {
  ConstantColors cc = ConstantColors();
  converUnit(String unit) {
    // if (unit.contains('.')) {
    //   var a = unit.split('.');
    //   return a[1];
    // } else {
    //   return unit;
    // }
    var a = unit.split('.');
    return a[1];
  }

  getImage(int i, var data) {
    if (i == 0) {
      return "https://dawnsapps.com/${data.homeBanner1}";
    } else if (i == 1) {
      return "https://dawnsapps.com/${data.homeBanner2}";
    } else {
      return "https://dawnsapps.com/${data.homeBanner3}";
    }
  }

  //slider
  Widget topSlider(double height, Color color) {
    return FutureBuilder<List>(
        future: SliderService().fetchSlider(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? CarouselSlider(
                    options: CarouselOptions(
                      height: height,
                      autoPlay: true,
                    ),
                    items: [1, 2, 3].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const SingleProduct()));
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        // fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                  imageUrl:
                                      "https://dawnsapps.com/${snapshot.data![i - 1]}",
                                  // placeholder: (context, url) {
                                  //   return Image.asset('assets/images/placeholder.png');
                                  // },
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )
                : const Text("error loading slider");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return const Text("No data found");
          } else {
            return const SizedBox(
              height: 150,
              // child: SpinKitRipple(
              //   color: ConstantColors().greyPrimary,
              //   size: 25.0,
              // ),
            );
          }
        });
  }

  updateAlert(BuildContext context) {
    return Alert(
      context: context,
      style: AlertStyle(
          overlayColor: Colors.black.withOpacity(.6),
          isButtonVisible: false,
          isOverlayTapDismiss: true,
          isCloseButton: true,
          alertPadding: EdgeInsets.zero,
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          animationType: AnimationType.grow,
          animationDuration: const Duration(milliseconds: 500)),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60.0,
            width: 100.0,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/dawn-icon.png'),
                  fit: BoxFit.fitHeight),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "New update available!",
            style: TextStyle(
                color: cc.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          //doctor designation
          Text(
            "Please update to get the latest feature",
            style:
                TextStyle(color: cc.greySecondary, fontSize: 14, height: 1.4),
          ),
          //button
          InkWell(
            onTap: () {
              launch(
                  'https://play.google.com/store/apps/details?id=com.dawn.stationary');
            },
            child: Container(
                margin: const EdgeInsets.only(top: 25),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 13),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: cc.primaryColor.withOpacity(0.32),
                        spreadRadius: -2,
                        blurRadius: 13,
                        offset:
                            const Offset(0, 8), // changes position of shadow
                      ),
                    ],
                    color: cc.primaryColor,
                    borderRadius: BorderRadius.circular(3)),
                child: const Text(
                  "Update",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    ).show();
  }
}
