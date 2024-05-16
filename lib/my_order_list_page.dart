import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingmall/enums/delivery_status.dart';
import 'package:shoppingmall/enums/payment_status.dart';
import 'package:shoppingmall/models/product.dart';
import 'constants.dart';

import 'models/order.dart';

class MyOrderListPage extends StatefulWidget {
  const MyOrderListPage({super.key});

  @override
  State<MyOrderListPage> createState() => _MyOrderListPageState();
}

class _MyOrderListPageState extends State<MyOrderListPage> {
  List<Product> productList = [
    Product(
      productNo: 1,
      productName: "노트북(Laptop)",
      productImageUrl: "https://picsum.photos/id/1/300/300",
      price: 600000,
    ),
    Product(
      productNo: 4,
      productName: "키보드(Keyboard)",
      productImageUrl: "https://picsum.photos/id/60/300/300",
      price: 50000,
    ),
  ];

  List<Order> orderList = [
    Order(
      orderId: 1,
      productNo: 1,
      orderDate: "2023-11-24",
      orderNo: "20231114-123456123",
      quantity: 2,
      totalPrice: 1200000,
      paymentStatus: "completed",
      deliveryStatus: "delivering",
    ),
    Order(
      orderId: 2,
      productNo: 4,
      orderDate: "2023-11-24",
      orderNo: "20231114-141020312",
      quantity: 3,
      totalPrice: 150000,
      paymentStatus: "waiting",
      deliveryStatus: "waiting",
    ),
  ];

  List<Map<int, int>> quantityList = [
    {1: 2},
    {4: 3},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("나의 주문목록"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: orderList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return orderContainer(
                    productNo: orderList[index].productNo ?? 0,
                    productName: productList[index].productName ?? "",
                    productImageUrl: productList[index].productImageUrl ?? "",
                    price: orderList[index].totalPrice ?? 0,
                    quantity: quantityList[index][orderList[index].productNo] ?? 0,
                    orderDate: orderList[index].orderDate ?? "",
                    orderNo: orderList[index].orderNo ?? "",
                    paymentStatus: orderList[index].paymentStatus ?? "",
                  deliveryStatus: orderList[index].deliveryStatus ?? "",
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("홈으로"),
        ),
      ),
    );
  }

  Widget orderContainer({
    required int productNo,
    required String productName,
    required String productImageUrl,
    required double price,
    required int quantity,
    required String orderDate,
    required String orderNo,
    required String paymentStatus,
    required String deliveryStatus
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "주문날짜: ${orderDate}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: productImageUrl,
                width: MediaQuery.of(context).size.width * 0.3,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return const Center(
                    child: Text("오류 발생"),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      productName,
                      textScaleFactor: 1.2,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("${numberFormat.format(price)}원"),
                    Text("수랑: $quantity"),
                    Text("합계: ${numberFormat.format(price * quantity)}원"),
                    Text(
                      "${PaymentStatus.getStatusName(paymentStatus).statusName} / ${DeliveryStatus.getStatusName(deliveryStatus).statusName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              FilledButton.tonal(
                  onPressed: () {},
                  child: const Text("주문취소"),
              ),
              const SizedBox(width: 10),
              FilledButton(
                  onPressed: () {},
                  child: const Text("배송조회"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}