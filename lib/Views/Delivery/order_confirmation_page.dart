// import 'package:dawnsapp/Services/Constants/constant_colors.dart';
// import 'package:dawnsapp/Services/coupon_service.dart';
// import 'package:dawnsapp/Services/products_service.dart';
// import 'package:dawnsapp/Views/Home/home.dart';
// import 'package:dawnsapp/Views/invoice/api/pdf_api.dart';
// import 'package:dawnsapp/Views/invoice/api/pdf_invoice_api.dart';
// import 'package:dawnsapp/Views/invoice/invoiceModel/customer.dart';
// import 'package:dawnsapp/Views/invoice/invoiceModel/invoice.dart';
// import 'package:dawnsapp/Views/invoice/invoiceModel/supplier.dart';
// import 'package:dawnsapp/Views/invoice/widget/button_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'checkoutpage_inputs.dart';

// class OrderConfirmationPage extends StatefulWidget {
//   const OrderConfirmationPage(
//       {Key? key,
//       this.orderedProducts,
//       this.customerName,
//       this.customerAddress,
//       this.ordernumber,
//       this.paymentMethod})
//       : super(key: key);
//   final orderedProducts;
//   final customerName;
//   final customerAddress;
//   final ordernumber;
//   final paymentMethod;

//   @override
//   State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
// }

// class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   bool checkedValue = false;
//   bool cashDelivery = true;
//   bool bkashDelivery = false;
//   bool nagadDelivery = false;
//   bool upayDelivery = false;
//   bool alreadyPaid = false;
//   String paymentMethod = "Cash on delivery";

//   TextEditingController billingmobileController = TextEditingController();
//   TextEditingController billingamountController = TextEditingController();
//   TextEditingController transactionIdcontroller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         Navigator.of(context).pushAndRemoveUntil(
//             MaterialPageRoute(builder: (context) => const HomePage()),
//             (Route<dynamic> route) => false);
//         return Future.value(true);
//       },
//       child: Scaffold(
//         // backgroundColor: Colors.white.withOpacity(.1),
//         appBar: AppBar(
//           title: Text("Order Number: ${widget.ordernumber}",
//               style: TextStyle(color: ConstantColors().greyPrimary)),
//           iconTheme: IconThemeData(
//             color: ConstantColors().greyPrimary, //change your color here
//           ),
//           backgroundColor: Colors.white,
//           centerTitle: true,
//           elevation: 0,
//         ),
//         body: //Product list ===================>
//             SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
//             child: Column(
//               children: [
//                 //confirmation card
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.04),
//                         spreadRadius: 0,
//                         blurRadius: 8,
//                         offset: const Offset(1, 0),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Icon(
//                         Icons.check_circle_rounded,
//                         size: 60,
//                         color: ConstantColors().greenColor,
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       widget.paymentMethod == "Cash on delivery"
//                           ? Text(
//                               "Order has been successfully placed. Your order number is ${widget.ordernumber}. Your payment is currently confirmed as ${widget.paymentMethod}. You can also pay now by choosing one of the following payment options",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: ConstantColors().greyPrimary,
//                                   fontSize: 17),
//                             )
//                           : Text(
//                               "Order has been successfully placed. Your order number is ${widget.ordernumber}. Your payment is currently confirmed as ${widget.paymentMethod}.",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: ConstantColors().greyPrimary,
//                                   fontSize: 17),
//                             ),

//                       //download invoice button
//                       const SizedBox(
//                         height: 23,
//                       ),
//                       ButtonWidget(
//                         text: 'Invoice PDF',
//                         onClicked: () async {
//                           final date = DateTime.now();
//                           // final dueDate = date.add(Duration(days: 7));

//                           final invoice = Invoice(
//                             supplier: const Supplier(
//                               name: 'DAWN STATIONERY',
//                               address: '144,MITFORD ROAD DHAKA',
//                               paymentInfo: '',
//                             ),
//                             customer: Customer(
//                               name: '${widget.customerName}',
//                               address: '${widget.customerAddress}',
//                             ),
//                             info: InvoiceInfo(
//                               date: date,
//                               // dueDate: '90',
//                               description: 'My description...',
//                               number: '${widget.ordernumber}',
//                             ),
//                             items: [
//                               for (int i = 0;
//                                   i < widget.orderedProducts.length;
//                                   i++)
//                                 InvoiceItem(
//                                   description:
//                                       '${widget.orderedProducts[i]['productName']}',
//                                   date: DateTime.now(),
//                                   quantity: widget.orderedProducts[i]
//                                       ['quantity'],
//                                   vat: 0.00,
//                                   unitPrice: widget.orderedProducts[i]
//                                           ['singlePrice']
//                                       .toDouble(),
//                                 ),
//                               //delivery charge
//                             ],
//                           );
//                           var coupon =
//                               Provider.of<CouponService>(context, listen: false)
//                                   .coupon;
//                           var totalprice = Provider.of<ProductService>(context,
//                                   listen: false)
//                               .totalPrice;
//                           final pdfFile = await PdfInvoiceApi.generate(
//                               invoice, coupon, totalprice);

//                           PdfApi.openFile(pdfFile);
//                         },
//                       ),
//                       const SizedBox(
//                         height: 12,
//                       ),
//                     ],
//                   ),
//                 ),

//                 //Payment method card
//                 const SizedBox(
//                   height: 25,
//                 ),
//                 widget.paymentMethod == "Cash on delivery"
//                     ? Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 12, horizontal: 20),
//                         margin: const EdgeInsets.only(bottom: 2),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.04),
//                               spreadRadius: 0,
//                               blurRadius: 8,
//                               offset: const Offset(1, 0),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text("Payment method",
//                                 style: TextStyle(
//                                     color: ConstantColors()
//                                         .greyPrimary
//                                         .withOpacity(.8),
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20)),
//                             const SizedBox(
//                               height: 12,
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: CheckboxListTile(
//                                     checkColor: Colors.white,
//                                     activeColor: ConstantColors().primaryColor,
//                                     contentPadding: const EdgeInsets.all(0),
//                                     title: Text(
//                                       "Cash on delivery",
//                                       style: TextStyle(
//                                           color: ConstantColors().greyPrimary,
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 15),
//                                     ),
//                                     value: cashDelivery,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         if (cashDelivery != true) {
//                                           paymentMethod = "Cash on delivery";
//                                           alreadyPaid = false;
//                                           cashDelivery = !cashDelivery;
//                                           upayDelivery = false;
//                                           nagadDelivery = false;
//                                           bkashDelivery = false;
//                                         }
//                                       });
//                                     },
//                                     controlAffinity: ListTileControlAffinity
//                                         .leading, //  <-- leading Checkbox
//                                   ),
//                                 ),
//                                 //bkash delivery
//                                 Expanded(
//                                   child: CheckboxListTile(
//                                     checkColor: Colors.white,
//                                     activeColor: ConstantColors().primaryColor,
//                                     contentPadding: const EdgeInsets.all(0),
//                                     title: Text(
//                                       "Pay with Bkash",
//                                       style: TextStyle(
//                                           color: ConstantColors().greyPrimary,
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 15),
//                                     ),
//                                     value: bkashDelivery,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         if (bkashDelivery != true) {
//                                           paymentMethod = "Bkash";
//                                           alreadyPaid = true;
//                                           bkashDelivery = !bkashDelivery;
//                                           upayDelivery = false;
//                                           cashDelivery = false;
//                                           nagadDelivery = false;
//                                         }
//                                       });
//                                     },
//                                     controlAffinity: ListTileControlAffinity
//                                         .leading, //  <-- leading Checkbox
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 Expanded(
//                                   child: CheckboxListTile(
//                                     checkColor: Colors.white,
//                                     activeColor: ConstantColors().primaryColor,
//                                     contentPadding: const EdgeInsets.all(0),
//                                     title: Text(
//                                       "Pay with Nagad",
//                                       style: TextStyle(
//                                           color: ConstantColors().greyPrimary,
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 15),
//                                     ),
//                                     value: nagadDelivery,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         if (nagadDelivery != true) {
//                                           paymentMethod = "Nagad";
//                                           alreadyPaid = true;
//                                           nagadDelivery = !nagadDelivery;
//                                           upayDelivery = false;
//                                           cashDelivery = false;
//                                           bkashDelivery = false;
//                                         }
//                                       });
//                                     },
//                                     controlAffinity: ListTileControlAffinity
//                                         .leading, //  <-- leading Checkbox
//                                   ),
//                                 ),
//                                 //bkash delivery
//                                 Expanded(
//                                   child: CheckboxListTile(
//                                     checkColor: Colors.white,
//                                     activeColor: ConstantColors().primaryColor,
//                                     contentPadding: const EdgeInsets.all(0),
//                                     title: Text(
//                                       "Pay with Upay",
//                                       style: TextStyle(
//                                           color: ConstantColors().greyPrimary,
//                                           fontWeight: FontWeight.w400,
//                                           fontSize: 15),
//                                     ),
//                                     value: upayDelivery,
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         if (upayDelivery != true) {
//                                           paymentMethod = "Upay";
//                                           alreadyPaid = true;
//                                           upayDelivery = !upayDelivery;
//                                           cashDelivery = false;
//                                           nagadDelivery = false;
//                                           bkashDelivery = false;
//                                         }
//                                       });
//                                     },
//                                     controlAffinity: ListTileControlAffinity
//                                         .leading, //  <-- leading Checkbox
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             //Transaction id

//                             (bkashDelivery == true ||
//                                     nagadDelivery == true ||
//                                     upayDelivery == true)
//                                 ? Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       RichText(
//                                         text: TextSpan(
//                                           text: 'Pay to this number:  ',
//                                           style: TextStyle(
//                                               color:
//                                                   ConstantColors().greyPrimary,
//                                               fontWeight: FontWeight.w400,
//                                               fontSize: 15),
//                                           children: <TextSpan>[
//                                             TextSpan(
//                                                 text: '017410354612',
//                                                 style: TextStyle(
//                                                     color: ConstantColors()
//                                                         .primaryColor,
//                                                     fontWeight:
//                                                         FontWeight.bold)),
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         height: 5,
//                                       ),
//                                       Text(
//                                         "Then enter the transaction Id of the payment",
//                                         style: TextStyle(
//                                             color: ConstantColors().greyPrimary,
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 15),
//                                       ),
//                                       const SizedBox(
//                                         height: 20,
//                                       ),
//                                       CheckoutPageInputs(
//                                         controller: billingmobileController,
//                                         hintText:
//                                             "Mobile number by which you paid",
//                                         isNumberField: true,
//                                         onChanged: (value) {},
//                                         onSubmitted: (value) {},
//                                         textInputAction: TextInputAction.next,
//                                       ),

//                                       //amount that user paid
//                                       CheckoutPageInputs(
//                                         controller: billingamountController,
//                                         hintText: "Amount that you paid (tk)",
//                                         isNumberField: true,
//                                         onChanged: (value) {},
//                                         onSubmitted: (value) {},
//                                         textInputAction: TextInputAction.next,
//                                       ),
//                                       //transaction id
//                                       CheckoutPageInputs(
//                                         controller: transactionIdcontroller,
//                                         hintText: "Transaction ID",
//                                         onChanged: (value) {},
//                                         onSubmitted: (value) {},
//                                         textInputAction: TextInputAction.next,
//                                       ),
//                                       const SizedBox(
//                                         height: 15,
//                                       ),
//                                       InkWell(
//                                         onTap: () {},
//                                         child: Container(
//                                             width: double.infinity,
//                                             alignment: Alignment.center,
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 15),
//                                             decoration: BoxDecoration(
//                                                 color: ConstantColors()
//                                                     .primaryColor,
//                                                 borderRadius:
//                                                     BorderRadius.circular(7)),
//                                             child: const Text(
//                                               "Pay now",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.bold),
//                                             )),
//                                       ),
//                                       const SizedBox(
//                                         height: 10,
//                                       ),
//                                     ],
//                                   )
//                                 : Container(),
//                           ],
//                         ),
//                       )
//                     : Container(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
