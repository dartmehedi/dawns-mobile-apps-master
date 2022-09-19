import 'package:dawnsapp/Models/sub_categories_drawer_model.dart';
import 'package:dawnsapp/Services/Constants/constant_colors.dart';
import 'package:dawnsapp/Services/sub_categories_drawer_service.dart';
import 'package:dawnsapp/Views/Products/drawer_category_product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SubCategoriesDrawer extends StatelessWidget {
  const SubCategoriesDrawer(
      {Key? key, this.catname = "Sub Category", required this.parentId})
      : super(key: key);
  final String catname;
  final int parentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ConstantColors().greyPrimary),
        title: Text(
          catname,
          style: TextStyle(color: ConstantColors().greyPrimary),
        ),
        backgroundColor: Colors.white,
        elevation: .4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 0),
              child: FutureBuilder<SubCategoryDrawerModel>(
                future: SubCategoriesDrawerService()
                    .fetchSubCategoryDrawer(parentId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: snapshot.data!.data[0].child.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DrawerCategoryProductList(
                                            subBrandName: snapshot.data!.data[0]
                                                        .child[index].title !=
                                                    null
                                                ? snapshot
                                                        .data!
                                                        .data[0]
                                                        .child[index]
                                                        .title![0] +
                                                    snapshot.data!.data[0]
                                                        .child[index].title!
                                                        .toLowerCase()
                                                        .substring(1)
                                                : " ",
                                            parentId: snapshot.data!.data[0]
                                                .child[index].categoryId,
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: ConstantColors()
                                              .dividerColor
                                              .withOpacity(.5)))),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 14,
                                    color: ConstantColors().greySecondary,
                                  ),
                                  const SizedBox(
                                    width: 11,
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 2),
                                    child: Text(
                                      snapshot.data!.data[0].child[index]
                                                  .title !=
                                              null
                                          ? snapshot.data!.data[0].child[index]
                                                  .title![0] +
                                              snapshot.data!.data[0]
                                                  .child[index].title!
                                                  .toLowerCase()
                                                  .substring(
                                                      1) //converting all uppercase to - first letter upper only
                                          : 'no data',
                                      overflow: TextOverflow.visible,
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontSize: 15,
                                          height: 1.3,
                                          fontWeight: FontWeight.w400,
                                          color: ConstantColors().greyPrimary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: const Center(child: Text("no data available")));
                  } else {
                    return Container(
                      height: MediaQuery.of(context).size.height - 120,
                      alignment: Alignment.center,
                      child: SpinKitThreeBounce(
                        color: ConstantColors().primaryColor,
                        size: 20.0,
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
