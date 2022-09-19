import 'package:mailer/mailer.dart';

import 'package:mailer/smtp_server.dart';

class EmailService {
  sendMail(
      orderNumber, orderedProducts, deliveryCharge, grandTotal, pdffile) async {
    // var a = "Product Id: 122, Product Name: Apple, Quantity: 7, Single Price: 100, Total Price: 700";
    loopProducts() {
      List list = [];
      var divided;

      for (int i = 0; i < orderedProducts.length; i++) {
        divided = "  ==============";
        divided =
            "Product Name: ${orderedProducts[i]['productName']}, Single price: ${orderedProducts[i]['singlePrice']}," +
                " Quantity: ${orderedProducts[i]['quantity']}, Total price: ${orderedProducts[i]['totalPrice']}" +
                divided;
        list.add(divided);
        divided = '';
      }
      return list;
    }

    // product = product + loopProducts();
    var prodList = loopProducts()
      ..add("Delivery Charge: $deliveryCharge")
      ..add("Grand Total: $grandTotal");
    var b = prodList.toString();
    var c = b.replaceAll('[', '');
    c = c.replaceAll(']', '');

    String username = 'info.zaimahtech@gmail.com';
    String password = 'Ztl@2021#';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add('info@dawn-stationery.com')
      ..subject = 'New order has been placed'
      ..text =
          'An order in DAWN STATIONERY has been placed. Order number is $orderNumber . Ordered products: $c'
      ..attachments = [
        FileAttachment(pdffile)
          ..location = Location.inline
          ..cid = '<invoice.141>'
      ];

    try {
      final sendReport = await send(message, smtpServer);
      print('Email sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent. $e');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
