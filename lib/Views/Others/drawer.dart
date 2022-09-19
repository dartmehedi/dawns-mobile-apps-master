import 'package:dawnsapp/Models/category_model.dart';
import 'package:dawnsapp/Services/category_service.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/email_service.dart';
import 'package:dawnsapp/Services/user_service.dart';
import 'package:dawnsapp/Views/Auth/sign_in.dart';
import 'package:dawnsapp/Views/Auth/sign_up.dart';
import 'package:dawnsapp/Views/Categories/sub_categories_drawer.dart';
import 'package:dawnsapp/Views/Delivery/order_active_list.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:dawnsapp/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          //header
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.only(left: 24, bottom: 27),
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Provider.of<UserService>(context, listen: true).userDetails ==
                        null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 60,
                            margin: const EdgeInsets.only(bottom: 25),
                            width: 153,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/logo.png'),
                                    fit: BoxFit.fitHeight)),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInPage()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 17),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white.withOpacity(.7)),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 17,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 17),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white.withOpacity(.7),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: const Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // CircleAvatar(
                          //   backgroundColor: Colors.white,
                          //   child: Container(
                          //     padding: const EdgeInsets.all(5),
                          //     decoration: const BoxDecoration(
                          //         shape: BoxShape.circle, color: Colors.white),
                          //     child: Text(
                          //         "${Provider.of<UserService>(context, listen: true).userDetails.name[0].toUpperCase()}",
                          //         style: TextStyle(
                          //           color: ConstantColors().greyPrimary,
                          //           fontSize: 26,
                          //           fontWeight: FontWeight.w400,
                          //         )),
                          //   ),
                          //   maxRadius: 26,
                          // ),

                          Text(
                            "${Provider.of<UserService>(context, listen: true).userDetails.name}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          Text(
                            "${Provider.of<UserService>(context, listen: true).userDetails.mobile}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${Provider.of<UserService>(context, listen: true).userDetails.address}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
              ],
            ),
          ),
          //Header end

          //menu list
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<List<CategoryModel>>(
                      future: CategoryService().fetchCategory(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              for (int i = 0; i < snapshot.data!.length; i++)
                                ListTile(
                                  leading: Icon(OthersHelper().icon[i]),
                                  title: Text(snapshot.data![i].title[0] +
                                      snapshot.data![i].title
                                          .toLowerCase()
                                          .substring(
                                              1)), // here we are trying to make the first letter uppercase because the string coming from database is all caps
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SubCategoriesDrawer(
                                                  catname: snapshot
                                                          .data![i].title[0] +
                                                      snapshot.data![i].title
                                                          .toLowerCase()
                                                          .substring(1),
                                                  parentId:
                                                      snapshot.data![i].id,
                                                )));
                                  },
                                ),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          return const Text("no data found");
                        } else {
                          return Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SpinKitThreeBounce(
                                color: ConstantColors().primaryColor,
                                size: 20.0,
                              ),
                            ],
                          );
                        }
                      }),
                  Divider(
                    color: Colors.grey[400],
                  ),
                  // ListTile(
                  //   leading: const Icon(Icons.shopping_bag_outlined),
                  //   title: const Text(
                  //       "Send mail"), // here we are trying to make the first letter uppercase because the string coming from database is all caps
                  //   onTap: () async {
                  //     EmailService().sendMail();
                  //   },
                  // ),
                  ListTile(
                    leading: const Icon(Icons.shopping_bag_outlined),
                    title: const Text(
                        "My Orders"), // here we are trying to make the first letter uppercase because the string coming from database is all caps
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrderActiveList()));
                    },
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              launch("https://zaimahtech.com/");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Developed by',
                      style: TextStyle(
                          color: ConstantColors().greySecondary,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        TextSpan(
                            text: '  Zaimah Technologies',
                            style: TextStyle(
                                color: ConstantColors().secondaryColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  const Text(
                    "",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
