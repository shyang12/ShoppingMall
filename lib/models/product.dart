class Product {
  int? productNo;
  String? productName;
  String? productDetails;
  String? productImageUrl;
  double? price;

  Product ({
    this.productNo,
    this.productName,
    this.productDetails,
    this.productImageUrl,
    this.price
  });

  Product.fromJson(Map<String, dynamic> json) {
    productNo = int.parse(json['productNo']);
    productName = json['productName'];
    productDetails = json['productDetails'];
    productImageUrl = json['productImageUrl'];
    price = double.parse(json['price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['productNo'] = productNo;
    data['productName'] = productName;
    data['productDetails'] = productDetails;
    data['productImageUrl'] = productImageUrl;
    data['price'] = price;
    return data;
  }
}