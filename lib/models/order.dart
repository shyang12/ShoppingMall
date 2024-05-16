class Order {
  int? orderId;
  int? productNo;
  String? orderDate;
  String? orderNo;
  int? quantity;
  double? totalPrice;
  String? paymentStatus;
  String? deliveryStatus;

  Order({
    this.orderId,
    this.productNo,
    this.orderDate,
    this.orderNo,
    this.quantity,
    this.totalPrice,
    this.paymentStatus,
    this.deliveryStatus,
  });

  Order.fromJson(Map<String, dynamic> json) {
    orderId = int.parse(json['orderId']);
    productNo = json['productNo'];
    orderDate = json['orderDate'];
    orderNo = json['orderNo'];
    quantity = json['quantity'];
    totalPrice = double.parse(json['totalPrice']);
    paymentStatus = json['paymentStatus'];
    deliveryStatus = json['deliveryStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['orderId'] = orderId;
    data['productNo'] = productNo;
    data['orderDate'] = orderDate;
    data['orderNo'] = orderNo;
    data['quantity'] = quantity;
    data['paymentStatus'] = paymentStatus;
    data['deliveryStatus'] = deliveryStatus;
    return data;
  }
}