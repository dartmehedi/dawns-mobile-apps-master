import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Views/Products/cart_page.dart';
import 'package:dawnsapp/Views/Search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppbarMain extends StatelessWidget {
  const AppbarMain({Key? key, this.title}) : super(key: key);
  final title;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return AppBar(
        title: Text(
          "$title",
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
                child: Icon(
                  Icons.shopping_cart,
                  size: 23,
                  color: cc.greyPrimary,
                )),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {},
            child: Icon(
              Icons.menu,
              color: cc.greyPrimary,
            )));
  }
}
