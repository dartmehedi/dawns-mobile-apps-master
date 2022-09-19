// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'Services/products_service.dart';

// class TestPage extends StatefulWidget {
//   const TestPage({Key? key}) : super(key: key);

//   @override
//   State<TestPage> createState() => _TestPageState();
// }

// class _TestPageState extends State<TestPage> {
//   @override
//   Widget build(BuildContext context) {
//     var listen = Provider.of<ProductService>(context, listen: true);
//     print("Rebuilding");
//     return Scaffold(
//       body: Center(
//         child: Text(listen.totalPrice.toString()),
//       ),
//     );
//   }
// }
