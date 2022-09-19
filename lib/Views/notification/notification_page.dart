import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage(
      {Key? key, this.title = " ", this.desc = " ", this.imageLink})
      : super(key: key);
  final title;
  final desc;
  final imageLink;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications",
            style: TextStyle(
                color: ConstantColors().greyPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 18)),
        iconTheme: IconThemeData(
          color: ConstantColors().greyPrimary, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageLink != null
              ? Container(
                  height: 180.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(imageLink), fit: BoxFit.fitWidth),
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title != null ? "$title" : " ",
                    style: TextStyle(
                      color: ConstantColors().greyPrimary,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    desc != null ? "$desc" : " ",
                    style: TextStyle(
                      color: ConstantColors().greyPrimary,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
