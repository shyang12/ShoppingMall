import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shoppingmall/item_basket_page.dart';
import 'package:shoppingmall/item_details_page.dart';
import 'package:shoppingmall/models/product.dart';
import 'package:shoppingmall/my_order_list_page.dart';
import 'package:shoppingmall/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemListPage extends StatefulWidget {
  const ItemListPage({super.key});

  @override
  State<ItemListPage> createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  final productListRef = FirebaseFirestore.instance
      .collection("products")
      .withConverter(
      fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
      toFirestore: (product, _) => product.toJson());

  List<Product> productList = [
    Product(
        productNo: 1,
        productName: "노트북(Laptop)",
        productImageUrl: "https://picsum.photos/id/1/300/300",
        price: 600000),
    Product(
        productNo: 2,
        productName: "스마트폰(Phone)",
        productImageUrl: "https://picsum.photos/id/20/300/300",
        price: 500000),
    Product(
        productNo: 3,
        productName: "머그컵(Cup)",
        productImageUrl: "https://picsum.photos/id/30/300/300",
        price: 15000),
    Product(
        productNo: 4,
        productName: "키보드(Keyboard)",
        productImageUrl: "https://picsum.photos/id/60/300/300",
        price: 50000),
    Product(
        productNo: 5,
        productName: "포도(Grape)",
        productImageUrl: "https://picsum.photos/id/75/200/300",
        price: 75000),
    Product(
        productNo: 6,
        productName: "책(book)",
        productImageUrl: "https://picsum.photos/id/24/200/300",
        price: 24000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("제품 리스트"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const MyOrderListPage();
                  },
              ));
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const ItemBasketPage();
                },
              ));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: productListRef.orderBy("productNo").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.8, crossAxisCount: 2),
            children: snapshot.data!.docs.map((document) {
              return productContainer(
                  productNo: document.data().productNo ?? 0,
                  productName: document.data().productName ?? "",
                  productImageUrl: document.data().productImageUrl ?? "",
                  price: document.data().price ?? 0,
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                "오류가 발생했습니다.",
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        }),
    );
  }

  Widget productContainer(
      {required int productNo,
        required String productName,
        required String productImageUrl,
        required double price}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ItemDetailsPage(productNo: productNo, productName: productName, productImageUrl: productImageUrl, price: price);
        },));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            CachedNetworkImage(
              height: 150,
              fit: BoxFit.cover,
              imageUrl: productImageUrl,
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
              padding: const EdgeInsets.all(8),
              child: Text(productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
            ),
      
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("${numberFormat.format(price)}원"),
            ),
          ],
        ),
      ),
    );
  }
}



