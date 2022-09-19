import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:dawnsapp/test.dart';
import 'package:flutter/material.dart';

import '../Home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkConnection() async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        OthersHelper()
            .showToast("Please turn on your internet connection", Colors.black);
      }
    }

    checkConnection();
    //=====  delete all cache in every month. date: 15 ============
    // var now = DateTime.now();
    // var formatter = DateFormat('dd');
    // String formattedDate = formatter.format(now);
    // deleteCache() async {
    //   await APICacheManager().emptyCache();
    // }

    // if (int.parse(formattedDate) == 15) {
    //   print(
    //       "all cache deleted, which is scheduled in splash screen- in every month");
    //   deleteCache().then((value) => Timer(const Duration(seconds: 1), () {
    //         Navigator.pushReplacement(context,
    //             MaterialPageRoute(builder: (context) => const HomePage()));
    //       }));
    // } else {
    //   Timer(const Duration(seconds: 1), () {
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => const HomePage()));
    //   });
    // }
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/splash.png'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
