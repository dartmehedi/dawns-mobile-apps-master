import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/coupon_service.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Views/Home/home.dart';
import 'package:dawnsapp/Views/Others/invoice_layout.dart';
import 'package:dawnsapp/Views/invoice/api/pdf_api.dart';
import 'package:dawnsapp/Views/invoice/api/pdf_invoice_api.dart';
import 'package:dawnsapp/Views/invoice/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderSuccessfulPage extends StatefulWidget {
  const OrderSuccessfulPage(
      {Key? key,
      this.orderedProducts,
      this.customerName,
      this.customerAddress,
      this.ordernumber,
      this.customerPhone,
      this.notes})
      : super(key: key);
  final orderedProducts;
  final customerName;
  final customerAddress;
  final ordernumber;
  final customerPhone;
  final notes;

  @override
  State<OrderSuccessfulPage> createState() => _OrderSuccessfulPageState();
}

class _OrderSuccessfulPageState extends State<OrderSuccessfulPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (Route<dynamic> route) => false);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: ConstantColors().greyPrimary, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        body: //Product list ===================>
            Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle_rounded,
                size: 60,
                color: ConstantColors().greenColor,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Order has been successfully placed",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ConstantColors().greyPrimary, fontSize: 25),
              ),
              const SizedBox(
                height: 35,
              ),
              ButtonWidget(
                text: 'Invoice PDF',
                onClicked: () async {
                  final date = DateTime.now();
                  // final dueDate = date.add(Duration(days: 7));

                  final invoice = invoiceLayout(
                      widget.customerName,
                      widget.customerAddress,
                      widget.ordernumber,
                      widget.orderedProducts);
                  var coupon =
                      Provider.of<CouponService>(context, listen: false).coupon;
                  var totalprice =
                      Provider.of<ProductService>(context, listen: false)
                          .totalPrice;

                  final pdfFile = await PdfInvoiceApi.generate(
                      invoice,
                      coupon,
                      totalprice,
                      "${widget.ordernumber}-invoice",
                      widget.customerPhone,
                      widget.notes);

                  PdfApi.openFile(pdfFile);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
