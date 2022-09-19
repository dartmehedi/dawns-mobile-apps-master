// import 'package:dawnsapp/Services/Constants/constant_colors.dart';
// import 'package:dawnsapp/Views/Search/search_page.dart';
// import 'package:flutter/material.dart';
// import 'package:page_transition/page_transition.dart';

// import '../Products/cart_page.dart';

// class SubCategoryPage extends StatelessWidget {
//   const SubCategoryPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     ConstantColors cc = ConstantColors();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Sub category",
//           style: TextStyle(color: ConstantColors().greyPrimary),
//         ),
//         actions: [
//           //search icon
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   PageTransition(
//                       type: PageTransitionType.rightToLeft,
//                       child: const SearchPage()));
//             },
//             child: Container(
//               padding: const EdgeInsets.only(right: 15, left: 15),
//               child: Icon(
//                 Icons.search,
//                 color: cc.greyPrimary,
//               ),
//             ),
//           ),

//           //cart page icon
//           InkWell(
//             splashColor: Colors.transparent,
//             highlightColor: Colors.transparent,
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const CartPage()));
//             },
//             child: Container(
//                 margin: const EdgeInsets.only(right: 25, left: 15),
//                 child: Icon(
//                   Icons.shopping_cart,
//                   size: 23,
//                   color: cc.greyPrimary,
//                 )),
//           ),
//         ],
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: IconThemeData(
//           color: ConstantColors().greyPrimary, //change your color here
//         ),
//         // leading: InkWell(
//         //     onTap: () {},
//         //     child: Icon(
//         //       Icons.menu,
//         //       color: cc.greyPrimary,
//         //     ))
//       ),
//       body: //Product list ===================>
//           Container(
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
//         child: Row(
//           children: [
//             Expanded(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: 8,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       // Navigator.push(
//                       //     context,
//                       //     MaterialPageRoute(
//                       //         builder: (context) =>  SingleProduct()));
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 14),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.06),
//                             spreadRadius: 0,
//                             blurRadius: 8,
//                             offset: const Offset(1, 0),
//                           ),
//                         ],
//                       ),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           //product image left sided
//                           Container(
//                             margin: const EdgeInsets.symmetric(vertical: 10),
//                             height: 50,
//                             width: 50,
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     image: NetworkImage(
//                                         "https://cdn.pixabay.com/photo/2013/07/13/10/26/egg-157224__340.png"),
//                                     fit: BoxFit.fitHeight)),
//                           ),
//                           const SizedBox(
//                             width: 14,
//                           ),

//                           //product name and price and kg ===================
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Product name",
//                                   style: TextStyle(
//                                       color: ConstantColors().greyPrimary,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15),
//                                   overflow: TextOverflow.ellipsis,
//                                   maxLines: 2,
//                                 ),
//                                 const SizedBox(
//                                   height: 6,
//                                 ),
//                                 //Product price and offer texts
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "৳ 200",
//                                       style: TextStyle(
//                                           color: ConstantColors().primaryColor,
//                                           fontWeight: FontWeight.w600,
//                                           fontSize: 14),
//                                     ),
//                                     const SizedBox(
//                                       width: 10,
//                                     ),
//                                     Text(
//                                       "৳ 250",
//                                       style: TextStyle(
//                                           color: ConstantColors().greySecondary,
//                                           fontWeight: FontWeight.w600,
//                                           decoration:
//                                               TextDecoration.lineThrough,
//                                           fontSize: 13),
//                                     ),
//                                     const SizedBox(
//                                       width: 15,
//                                     ),
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 9, vertical: 2),
//                                       decoration: BoxDecoration(
//                                         color: ConstantColors()
//                                             .secondaryColor
//                                             .withOpacity(0.1),
//                                         borderRadius: BorderRadius.circular(50),
//                                       ),
//                                       child: Text(
//                                         "1kg",
//                                         style: TextStyle(
//                                             color:
//                                                 ConstantColors().secondaryColor,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           //==========Product name and price and kg section end=============//

//                           //add to cart icon =================
//                           Material(
//                             color: Colors.transparent,
//                             child: InkWell(
//                               onTap: () {},
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 17, horizontal: 17),
//                                 child: Icon(
//                                   Icons.add_circle_outline,
//                                   color: ConstantColors().greySecondary,
//                                 ),
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
