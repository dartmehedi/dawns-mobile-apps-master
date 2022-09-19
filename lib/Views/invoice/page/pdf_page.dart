// import 'package:dawnsapp/Views/invoice/api/pdf_api.dart';
// import 'package:dawnsapp/Views/invoice/api/pdf_invoice_api.dart';
// import 'package:dawnsapp/Views/invoice/invoiceModel/customer.dart';
// import 'package:dawnsapp/Views/invoice/invoiceModel/invoice.dart';
// import 'package:dawnsapp/Views/invoice/invoiceModel/supplier.dart';
// import 'package:dawnsapp/Views/invoice/widget/button_widget.dart';
// import 'package:dawnsapp/Views/invoice/widget/title_widget.dart';
// import 'package:flutter/material.dart';

// class PdfPage extends StatefulWidget {
//   @override
//   _PdfPageState createState() => _PdfPageState();
// }

// class _PdfPageState extends State<PdfPage> {
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         backgroundColor: Colors.black,
//         appBar: AppBar(
//           title: Text("title"),
//           centerTitle: true,
//         ),
//         body: Container(
//           padding: EdgeInsets.all(32),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 // TitleWidget(
//                 //   icon: Icons.picture_as_pdf,
//                 //   text: 'Generate Invoice',
//                 // ),
//                 const SizedBox(height: 48),
//                 ButtonWidget(
//                   text: 'Invoice PDF',
//                   onClicked: () async {
//                     final date = DateTime.now();
//                     final dueDate = date.add(Duration(days: 7));

//                     final invoice = Invoice(
//                       supplier: Supplier(
//                         name: 'Sarah Field',
//                         address: 'Sarah Street 9, Beijing, China',
//                         paymentInfo: 'https://paypal.me/sarahfieldzz',
//                       ),
//                       customer: Customer(
//                         name: 'Apple Inc.',
//                         address: 'Apple Street, Cupertino, CA 95014',
//                       ),
//                       info: InvoiceInfo(
//                         date: date,
//                         // dueDate: dueDate,
//                         description: 'My description...',
//                         number: '${DateTime.now().year}-9999',
//                       ),
//                       items: [
//                         for (int i = 0; i < 5; i++)
//                           InvoiceItem(
//                             description: 'Coffee $i',
//                             date: DateTime.now(),
//                             quantity: i,
//                             vat: 0.19,
//                             unitPrice: i * 5.toDouble(),
//                           ),
//                       ],
//                     );

//                     final pdfFile = await PdfInvoiceApi.generate(invoice);

//                     PdfApi.openFile(pdfFile);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
// }
