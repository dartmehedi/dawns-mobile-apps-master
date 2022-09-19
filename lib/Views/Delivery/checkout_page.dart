import 'package:dawnsapp/Services/Addtocart/addto_cart_service.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/coupon_service.dart';
import 'package:dawnsapp/Services/order_service.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Services/user_service.dart';
import 'package:dawnsapp/Views/Delivery/checkout_page_helper.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'checkoutpage_inputs.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with SingleTickerProviderStateMixin {
  late FocusNode focusNode;

  AnimationController? _controller;
  Animation? _animation;
  bool checkedValue = false;
  bool cashDelivery = true;
  bool bkashDelivery = false;
  bool nagadDelivery = false;
  bool rocketDelivery = false;
  bool alreadyPaid = false;
  bool createAccountForlater = false;
  String paymentMethod = "Cash on delivery";

  String dropdownValue = 'Select District';
  String selectAreaValue = 'Select Area';

  var userData;
  @override
  void initState() {
    //get user details if logged in
    userData = Provider.of<UserService>(context, listen: false).userDetails;
    if (userData != null) {
      namecontroller.text = userData.name;
      phonecontroller.text = userData.mobile;
      addresscontroller.text = userData.address;
    }

    focusNode = FocusNode();
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    });
  }

  TextEditingController couponController = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController transactionIdcontroller = TextEditingController();
  TextEditingController notescontroller = TextEditingController();
  TextEditingController billingmobileController = TextEditingController();
  TextEditingController billingamountController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String vErrorMessage = "";

  @override
  Widget build(BuildContext context) {
    var providerListen = Provider.of<AddtoCartService>(context, listen: true);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Checkout",
            style: TextStyle(color: ConstantColors().greyPrimary),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(
            color: ConstantColors().greyPrimary, //change your color here
          ),
        ),
        body: Listener(
          onPointerDown: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.focusedChild?.unfocus();
            }
          },
          child: SingleChildScrollView(
            child: Container(
              color: ConstantColors().greySecondary.withOpacity(.04),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Column(
                children: [
                  //All item summary show card
                  CheckoutPageHelper().checkoutCard(context, couponController),

                  // user details
                  const SizedBox(height: 23),
                  Container(
                    padding: const EdgeInsets.fromLTRB(25, 20, 25, 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(1, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delivery Details",
                            style: TextStyle(
                                color: ConstantColors()
                                    .greyPrimary
                                    .withOpacity(.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        const SizedBox(
                          height: 24,
                        ),

                        //Name
                        CheckoutPageInputs(
                          controller: namecontroller,
                          hintText: "Your Name",
                          validatonMessage: vErrorMessage,
                          onChanged: (value) {},
                          onSubmitted: (value) {},
                          textInputAction: TextInputAction.next,
                        ),

                        //Phone
                        CheckoutPageInputs(
                          controller: phonecontroller,
                          hintText: "Phone",
                          
                          onChanged: (value) {},
                          onSubmitted: (value) {},
                          textInputAction: TextInputAction.next,
                          isNumberField: true,
                        ),

                        //Address
                        CheckoutPageInputs(
                          controller: addresscontroller,
                          hintText: "Full Address",
                          onChanged: (value) {},
                          onSubmitted: (value) {},
                          textInputAction: TextInputAction.next,
                        ),

                        //notes
                        CheckoutPageInputs(
                          controller: notescontroller,
                          hintText: "Notes",
                          onChanged: (value) {},
                          onSubmitted: (value) {},
                          textInputAction: TextInputAction.next,
                        ),

                        userData == null
                            ? CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: ConstantColors().primaryColor,
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  "Create an account for later use",
                                  style: TextStyle(
                                      color: ConstantColors().greyPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                value: checkedValue,
                                onChanged: (newValue) {
                                  setState(() {
                                    checkedValue = !checkedValue;
                                    createAccountForlater =
                                        !createAccountForlater;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              )
                            : Container(),

                        //email password for later use
                        createAccountForlater == true
                            ? Column(
                                children: [
                                  SizedBox(height: 15),
                                  //email
                                  CheckoutPageInputs(
                                    controller: emailController,
                                    hintText: "Your email",
                                    validatonMessage:vErrorMessage,
                                    onChanged: (value) {},
                                    onSubmitted: (value) {},
                                    textInputAction: TextInputAction.next,
                                  ),
                                  //password
                                  CheckoutPageInputs(
                                    controller: passController,
                                    hintText: "Password",
                                    onChanged: (value) {},
                                    onSubmitted: (value) {},
                                    textInputAction: TextInputAction.next,
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),

                  //Payment method card
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 20),
                    margin: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(1, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Payment method",
                            style: TextStyle(
                                color: ConstantColors()
                                    .greyPrimary
                                    .withOpacity(.8),
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: ConstantColors().primaryColor,
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  "Cash on delivery",
                                  style: TextStyle(
                                      color: ConstantColors().greyPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                value: cashDelivery,
                                onChanged: (newValue) {
                                  setState(() {
                                    if (cashDelivery != true) {
                                      paymentMethod = "Cash on delivery";
                                      alreadyPaid = false;
                                      cashDelivery = !cashDelivery;
                                      rocketDelivery = false;
                                      nagadDelivery = false;
                                      bkashDelivery = false;
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                            //bkash delivery
                            Expanded(
                              child: CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: ConstantColors().primaryColor,
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  "Pay with Bkash",
                                  style: TextStyle(
                                      color: ConstantColors().greyPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                value: bkashDelivery,
                                onChanged: (newValue) {
                                  setState(() {
                                    if (bkashDelivery != true) {
                                      paymentMethod = "Bkash";
                                      alreadyPaid = true;
                                      bkashDelivery = !bkashDelivery;
                                      rocketDelivery = false;
                                      cashDelivery = false;
                                      nagadDelivery = false;
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: ConstantColors().primaryColor,
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  "Pay with Nagad",
                                  style: TextStyle(
                                      color: ConstantColors().greyPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                value: nagadDelivery,
                                onChanged: (newValue) {
                                  setState(() {
                                    if (nagadDelivery != true) {
                                      paymentMethod = "Nagad";
                                      alreadyPaid = true;
                                      nagadDelivery = !nagadDelivery;
                                      rocketDelivery = false;
                                      cashDelivery = false;
                                      bkashDelivery = false;
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                            //bkash delivery
                            Expanded(
                              child: CheckboxListTile(
                                checkColor: Colors.white,
                                activeColor: ConstantColors().primaryColor,
                                contentPadding: const EdgeInsets.all(0),
                                title: Text(
                                  "Pay with Rocket",
                                  style: TextStyle(
                                      color: ConstantColors().greyPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                                value: rocketDelivery,
                                onChanged: (newValue) {
                                  setState(() {
                                    if (rocketDelivery != true) {
                                      paymentMethod = "Rocket";
                                      alreadyPaid = true;
                                      rocketDelivery = !rocketDelivery;
                                      cashDelivery = false;
                                      nagadDelivery = false;
                                      bkashDelivery = false;
                                    }
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .leading, //  <-- leading Checkbox
                              ),
                            ),
                          ],
                        ),

                        //Transaction id

                        (bkashDelivery == true ||
                                nagadDelivery == true ||
                                rocketDelivery == true)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Pay to this number:  ',
                                      style: TextStyle(
                                          color: ConstantColors().greyPrimary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: bkashDelivery == true
                                                ? '01815554790'
                                                : nagadDelivery == true
                                                    ? "01819425080"
                                                    : "018155547905",
                                            style: TextStyle(
                                                color: ConstantColors()
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Then enter the transaction Id of the payment",
                                    style: TextStyle(
                                        color: ConstantColors().greyPrimary,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CheckoutPageInputs(
                                    controller: billingmobileController,
                                    hintText: "Mobile number by which you paid",
                                    isNumberField: true,
                                    onChanged: (value) {},
                                    onSubmitted: (value) {},
                                    textInputAction: TextInputAction.next,
                                  ),

                                  //amount that user paid
                                  CheckoutPageInputs(
                                    controller: billingamountController,
                                    hintText: "Amount that you paid (tk)",
                                    isNumberField: true,
                                    onChanged: (value) {},
                                    onSubmitted: (value) {},
                                    textInputAction: TextInputAction.next,
                                  ),
                                  //transaction id
                                  CheckoutPageInputs(
                                    controller: transactionIdcontroller,
                                    hintText: "Transaction ID",
                                    onChanged: (value) {},
                                    onSubmitted: (value) {},
                                    textInputAction: TextInputAction.next,
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),

                  //Place order button
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.focusedChild?.unfocus();
                      }
                      //----------------------------------------validation check
                      if (validation()) {
                        if (Provider.of<OrderService>(context, listen: false)
                                .loading ==
                            false) {
                          //place order
                          OrderService().placeOrder(
                              context,
                              namecontroller.text,
                              phonecontroller.text,
                              addresscontroller.text,
                              notescontroller.text,
                              Provider.of<CouponService>(context, listen: false)
                                  .getcoupon(),

                              //sending delivery charge
                              //if total order is greater than 500 tk then delivery charge is zero else 60tk
                              Provider.of<ProductService>(context,
                                              listen: false)
                                          .totalPrice >=
                                      500
                                  ? 0
                                  : OthersHelper().deliveryCharge,
                              //sending grand total charge
                              //if total order is greater than 500 then no delivery charge, if greater than 500 then
                              //delivery charge 60. coupon is already getting subracted from total when coupon is applied
                              Provider.of<ProductService>(context,
                                              listen: false)
                                          .totalPrice >=
                                      500
                                  ? Provider.of<ProductService>(context,
                                          listen: false)
                                      .totalPrice
                                  : (Provider.of<ProductService>(context,
                                              listen: false)
                                          .totalPrice +
                                      OthersHelper().deliveryCharge),
                              //sending subtotal (without coupon, delivery charge)
                              Provider.of<ProductService>(context,
                                      listen: false)
                                  .totalPrice,
                              //billing mobile number
                              billingmobileController.text,
                              //transaction id number
                              transactionIdcontroller.text,
                              //payment method
                              paymentMethod,
                              //billing amount
                              billingamountController.text,
                              alreadyPaid,
                              createAccountForlater,
                              emailController.text,
                              passController.text);
                        }
                      }

                      // ------------------------validation check end
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          color: ConstantColors().primaryColor,
                          borderRadius: BorderRadius.circular(7)),
                      child: Provider.of<OrderService>(context, listen: true)
                                  .loading ==
                              false
                          ? const Text(
                              "Place Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          : const SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20.0,
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  bool validation() {
    if (namecontroller.text.isEmpty) {
      setState(() {
        vErrorMessage = "Enter your name, The name  is required.";
      });
      return false;
    } else if(emailController.text.isEmpty) {
      setState(() {
        vErrorMessage = "Enter your email, The email  is required.";
      });
      return false;
    }
    
    
    else {
      return true;
    }
  }
}
