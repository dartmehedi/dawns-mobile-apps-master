// Expanded(
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               const SizedBox(
//                                                 height: 11,
//                                               ),
//                                               Text(
//                                                 productList[index]
//                                                         .productName ??
//                                                     '0',
//                                                 style: TextStyle(
//                                                     color: ConstantColors()
//                                                         .greyPrimary,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 15),
//                                                 overflow: TextOverflow.ellipsis,
//                                                 maxLines: 1,
//                                               ),
//                                               //Product price and offer texts
//                                               Row(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         "৳ ${productList[index].sellingPrice}",
//                                                         style: TextStyle(
//                                                             color:
//                                                                 ConstantColors()
//                                                                     .primaryColor,
//                                                             fontWeight:
//                                                                 FontWeight.w600,
//                                                             fontSize: 14),
//                                                       ),
//                                                       const SizedBox(
//                                                         width: 10,
//                                                       ),
//                                                       Text(
//                                                         "৳ 250",
//                                                         style: TextStyle(
//                                                             color: ConstantColors()
//                                                                 .greySecondary,
//                                                             fontWeight:
//                                                                 FontWeight.w600,
//                                                             decoration:
//                                                                 TextDecoration
//                                                                     .lineThrough,
//                                                             fontSize: 13),
//                                                       ),
//                                                       const SizedBox(
//                                                         width: 15,
//                                                       ),
//                                                       productList[index].unit !=
//                                                               null
//                                                           ? Container(
//                                                               padding: const EdgeInsets
//                                                                       .symmetric(
//                                                                   horizontal: 9,
//                                                                   vertical: 2),
//                                                               decoration:
//                                                                   BoxDecoration(
//                                                                 color: ConstantColors()
//                                                                     .secondaryColor
//                                                                     .withOpacity(
//                                                                         0.1),
//                                                                 borderRadius:
//                                                                     BorderRadius
//                                                                         .circular(
//                                                                             50),
//                                                               ),
//                                                               child: Text(
//                                                                 "1 ${HomepageHelper().converUnit(productList[index].unit.toString())}",
//                                                                 style: TextStyle(
//                                                                     color: ConstantColors()
//                                                                         .secondaryColor,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w600),
//                                                               ),
//                                                             )
//                                                           : Container(),
//                                                     ],
//                                                   ),

//                                                   //add to cart icon =================
//                                                   Expanded(
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment.end,
//                                                       children: [
//                                                         //decrease button ===================
//                                                         InkWell(
//                                                           splashColor: Colors
//                                                               .transparent,
//                                                           highlightColor: Colors
//                                                               .transparent,
//                                                           onTap: () {},
//                                                           child: Container(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(10),
//                                                             child: Icon(
//                                                               Icons
//                                                                   .remove_circle_outline,
//                                                               color: ConstantColors()
//                                                                   .greySecondary,
//                                                             ),
//                                                           ),
//                                                         ),

//                                                         //Quantity
//                                                         Container(
//                                                           child: Text(
//                                                             "${0}",
//                                                             style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 color: ConstantColors()
//                                                                     .secondaryColor),
//                                                           ),
//                                                         ),

//                                                         //increase button ===================
//                                                         InkWell(
//                                                           splashColor: Colors
//                                                               .transparent,
//                                                           highlightColor: Colors
//                                                               .transparent,
//                                                           onTap: () {
//                                                             DbService()
//                                                                 .insertData(
//                                                                     productList[
//                                                                             index]
//                                                                         .id,
//                                                                     productList[
//                                                                             index]
//                                                                         .productName,
//                                                                     productList[
//                                                                             index]
//                                                                         .defaultImage,
//                                                                     int.parse(
//                                                                       productList[
//                                                                               index]
//                                                                           .sellingPrice,
//                                                                     ),
//                                                                     1,
//                                                                     context);
//                                                           },
//                                                           child: Container(
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(10),
//                                                             child: Icon(
//                                                               Icons
//                                                                   .add_circle_outline,
//                                                               color: ConstantColors()
//                                                                   .greySecondary,
//                                                             ),
//                                                           ),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),