import 'dart:io';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:dawnsapp/Views/invoice/api/pdf_api.dart';
import 'package:dawnsapp/Views/invoice/invoiceModel/customer.dart';
import 'package:dawnsapp/Views/invoice/invoiceModel/invoice.dart';
import 'package:dawnsapp/Views/invoice/invoiceModel/supplier.dart';
import 'package:dawnsapp/Views/invoice/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice, couponDiscount, totalPrice,
      pdfName, phone, notes) async {
    final pdf = Document();
//getting asset image as file
    Future<File> getImageFileFromAssets(String path) async {
      final byteData = await rootBundle.load('assets/$path');

      final file = File('${(await getTemporaryDirectory()).path}/$path');
      await file.create(recursive: true);
      await file.writeAsBytes(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      return file;
    }

    File f = await getImageFileFromAssets('images/dawn-icon-bw.png');
    final image = pw.MemoryImage(
      f.readAsBytesSync(),
    );
    //end of getting asset image as file

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, phone, image, notes),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice, couponDiscount, totalPrice),
      ],
      // footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: '$pdfName.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice, phone, logo, notes) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier, logo),
              //barcode qrcode
              // Container(
              //   alignment: pw.Alignment.centerLeft,
              //   height: 60,
              //   width: 800,
              //   child: pw.Image(logo),
              // ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer, phone, notes),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildCustomerAddress(Customer customer, phone, notes) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address),
          Text(phone),
          notes != ''
              ? pw.Container(
                  width: 150,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Divider(),
                        Text("Notes: " + notes),
                      ]))
              : pw.Container(),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    // final paymentTerms = '${info.dueDate.difference(info.date).inDays} days';
    final titles = <String>[
      'Invoice Number:',
      'Invoice Date:',
      // 'Payment Terms:',
      // 'Due Date:'
    ];
    final data = <String>[
      info.number,
      Utils.formatDate(info.date),
      // paymentTerms,
      // Utils.formatDate(info.dueDate),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
  }

  static Widget buildSupplierAddress(Supplier supplier, logo) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //logo
          Container(
            alignment: pw.Alignment.centerLeft,
            height: 60,
            width: 200,
            child: pw.Image(logo),
          ),
          SizedBox(height: 3 * PdfPageFormat.mm),
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address),
        ],
      );

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          // Text(invoice.info.description),
          // SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Product name',
      'Date',
      'Quantity',
      'Unit Price',
      // 'VAT',
      'Total'
    ];
    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity;
      // * (1 + item.vat);

      return [
        item.description,
        Utils.formatDate(item.date),
        '${item.quantity}',
        '${item.unitPrice.toStringAsFixed(0)}',
        // '${item.vat} %',
        '${total.toStringAsFixed(0)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice, coupon, totalprice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //coupon discount
                buildText(
                  title: 'Coupon discount',
                  titleStyle: const TextStyle(
                    fontSize: 11,
                  ),
                  value: coupon.toString(),
                  unite: true,
                ),
                pw.SizedBox(height: 5),

                //delivery charge
                totalprice >= 500
                    ? buildText(
                        title: 'Delivery charge',
                        titleStyle: const TextStyle(
                          fontSize: 11,
                        ),
                        value: '0',
                        unite: true,
                      )
                    : buildText(
                        title: 'Delivery charge',
                        titleStyle: const TextStyle(
                          fontSize: 11,
                        ),
                        value: OthersHelper().deliveryCharge.toString(),
                        unite: true,
                      ),

                //net total
                pw.SizedBox(height: 5),
                totalprice >= 500
                    ? buildText(
                        title: 'Net total',
                        // value: netTotal.toStringAsFixed(0),
                        value: (totalprice).toStringAsFixed(0),
                        unite: true,
                      )
                    : buildText(
                        //if delivery charge is less than 500 then add delivery charge 60 tk
                        title: 'Net total',
                        // value: netTotal.toStringAsFixed(0),
                        value: (totalprice + OthersHelper().deliveryCharge)
                            .toStringAsFixed(0),
                        unite: true,
                      ),
                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: Utils.formatPrice(vat),
                //   unite: true,
                // ),
                // Divider(),

                SizedBox(height: 2 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400),  //border
                // SizedBox(height: 0.5 * PdfPageFormat.mm),
                // Container(height: 1, color: PdfColors.grey400), //border
              ],
            ),
          ),
        ],
      ),
    );
  }

  // static Widget buildFooter(Invoice invoice) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Divider(),
  //         SizedBox(height: 2 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Address', value: invoice.supplier.address),
  //         SizedBox(height: 1 * PdfPageFormat.mm),
  //         buildSimpleText(title: 'Paypal', value: invoice.supplier.paymentInfo),
  //       ],
  //     );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
