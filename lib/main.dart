import 'package:dawnsapp/Services/Addtocart/addto_cart_service.dart';
import 'package:dawnsapp/Services/coupon_service.dart';
import 'package:dawnsapp/Services/local_notification_service.dart';
import 'package:dawnsapp/Services/login_service.dart';
import 'package:dawnsapp/Services/orderDb/active_order_service.dart';
import 'package:dawnsapp/Services/order_service.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Services/search_service.dart';
import 'package:dawnsapp/Services/signup_service.dart';
import 'package:dawnsapp/Services/single_product_service.dart';
import 'package:dawnsapp/Services/user_service.dart';
import 'package:dawnsapp/Views/Others/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

///Receive message when app is in background solution for on message
Future<void> backgroundHandler(RemoteMessage message) async {
  print("on background handler ran");
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    // SystemUiOverlayStyle(
    //     statusBarColor: ConstantColors().primaryDeepColor));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SingleProductService()),
        ChangeNotifierProvider(create: (_) => AddtoCartService()),
        ChangeNotifierProvider(create: (_) => SearchService()),
        ChangeNotifierProvider(create: (_) => ProductService()),
        ChangeNotifierProvider(create: (_) => UserService()),
        ChangeNotifierProvider(create: (_) => CouponService()),
        ChangeNotifierProvider(create: (_) => ActiveOrderService()),
        ChangeNotifierProvider(create: (_) => OrderService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => SignUpService()),
        ChangeNotifierProvider(create: (_) => LocalNotificationValues()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dawn Stationery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
