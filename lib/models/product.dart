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

  Product.fromJson(Map<String, dynamic> json)
    : this(
        productNo: json['productNo'] as int,
        productName: json['productName'] as String,
        productImageUrl: json['productImageUrl'] as String,
        price: (json['price'] as int).toDouble(),
    );


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