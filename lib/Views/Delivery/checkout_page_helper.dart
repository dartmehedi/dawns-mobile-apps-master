import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/coupon_service.dart';
import 'package:dawnsapp/Services/products_service.dart';
import 'package:dawnsapp/Views/Others/others_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CheckoutPageHelper {
  Widget checkoutCard(BuildContext context, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 11),
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
        children: [
          //apply coupon section
          Provider.of<CouponService>(context, listen: true).isappliedCoupon ==
                  false
              ? Container(
                  margin: const EdgeInsets.only(bottom: 13),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              color: ConstantColors()
                                  .greySecondary
                                  .withOpacity(.07),
                              borderRadius: BorderRadius.circular(6)),
                          child: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter coupon",
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 13, vertical: 13)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      //apply coupon button
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            if (Provider.of<CouponService>(context,
                                        listen: false)
                                    .isloading ==
                                false) {
                              Provider.of<CouponService>(context, listen: false)
                                  .fetchCoupon(controller.text, context);
                              controller.clear();
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: ConstantColors().primaryColor,
                                borderRadius: BorderRadius.circular(7)),
                            child: Provider.of<CouponService>(context,
                                            listen: true)
                                        .isloading ==
                                    false
                                ? const Text(
                                    "Apply coupon",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  )
                                : const SpinKitThreeBounce(
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),

          //product with price list
          // Total price
          priceSummary('Order Total',
              "৳ ${Provider.of<ProductService>(context, listen: true).totalPrice}"),
          priceSummary('Coupon Discount',
              "৳ ${Provider.of<CouponService>(context, listen: true).getcoupon()}"),
          //delivery charge section
          priceSummary(
              'Delivery Charge',
              Provider.of<ProductService>(context, listen: false).totalPrice >=
                      500
                  ? 'free (for up to ৳500 order)'
                  : "৳ ${OthersHelper().deliveryCharge}"),

          //grand total section
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Grand Total",
                style: TextStyle(
                    color: ConstantColors().greySecondary,
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              const SizedBox(
                width: 16,
              ),
              //if total charge greater than or equal to 500 tk then delivery charge free else 60tk
              //coupon is already getting subracted from total when coupon is applied
              Text(
                "৳ ${(Provider.of<ProductService>(context, listen: true).totalPrice + (Provider.of<ProductService>(context, listen: true).totalPrice >= 500 ? 0 : OthersHelper().deliveryCharge))}",
                style: TextStyle(
                    color: ConstantColors().primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget priceSummary(String title, var price) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                  color: ConstantColors().greyPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  "$price",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: ConstantColors().greyPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

//payment method card

}
