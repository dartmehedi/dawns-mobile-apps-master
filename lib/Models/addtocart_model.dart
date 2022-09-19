class AddtocartModel {
  late int productId;
  late String productName;
  late String productImage;
  // late int colorId;
  // late int sizeId;
  late int singlePrice;
  late int totalPrice;
  late int quantity;
  late String unit;

  cartMap() {
    // ignore: unused_local_variable, prefer_collection_literals
    var mapping = Map<String, dynamic>();
    mapping['productId'] = productId;
    mapping['productName'] = productName;
    mapping['productImage'] = productImage;
    // mapping['colorId'] = colorId;
    // mapping['sizeId'] = sizeId;
    mapping['singlePrice'] = singlePrice;
    mapping['totalPrice'] = totalPrice;
    mapping['quantity'] = quantity;
    mapping['unit'] = unit;
    return mapping;
  }
}
