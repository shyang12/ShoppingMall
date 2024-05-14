import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shoppingmall/models/product.dart';
import 'constants.dart';

class ItemCheckoutPage extends StatefulWidget {
  const ItemCheckoutPage({super.key});

  @override
  State<ItemCheckoutPage> createState() => _ItemCheckoutPageState();
}

class _ItemCheckoutPageState extends State<ItemCheckoutPage> {
  List<Product> checkoutList = [
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

  List<Map<int, int>> quantityList = [
    {1: 2},
    {4: 3},
  ];

  double totalPrice = 0;

  // controller 변수 추가
  TextEditingController buyerNameController = TextEditingController();
  TextEditingController buyerEmailController = TextEditingController();
  TextEditingController buyerPhoneController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverPhoneController = TextEditingController();
  TextEditingController receiverZipController = TextEditingController();
  TextEditingController receiverAddress1Controller = TextEditingController();
  TextEditingController receiverAddress2Controller = TextEditingController();
  TextEditingController userPwdController = TextEditingController();
  TextEditingController userConfirmPwdController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController cardAuthController = TextEditingController();
  TextEditingController cardExpiredDateController = TextEditingController();
  TextEditingController cardPwdTwoDigitsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < checkoutList.length; i++) {
      totalPrice += checkoutList[i].price! * quantityList[i][checkoutList[i].productNo]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("결제시작"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: checkoutList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return checkoutContainer(
                    productNo: checkoutList[index].productNo ?? 0,
                    productName: checkoutList[index].productName ?? "",
                    productImageUrl: checkoutList[index].productImageUrl ?? "",
                    price: checkoutList[index].price ?? 0,
                    quantity: quantityList[index][checkoutList[index].productNo] ?? 0);
              },
            ),
            // 입력폼 필드
            buyerNameTextField(),
            buyerEmailTextField(),
            buyerPhoneTextField(),
            receiverNameTextField(),
            receiverPhoneTextField(),
            receiverZipTextField(),
            receiverAddress1TextField(),
            receiverAddress2TextField(),
            userPwdTextField(),
            userConfirmPwdTextField(),
            cardNoTextField(),
            cardAuthTextField(),
            cardExpiredDateTextField(),
            cardPwdTwoDigitsTextField(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () {},
          child: Text("총 ${numberFormat.format(totalPrice)}원 결제하기"),
        ),
      ),
    );
  }

  Widget checkoutContainer({
    required int productNo,
    required String productName,
    required String productImageUrl,
    required double price,
    required int quantity,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget buyerNameTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: buyerNameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "주문자명",
        ),
      ),
    );
  }

  Widget buyerEmailTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: buyerEmailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "주문자 이메일",
        ),
      ),
    );
  }

  Widget buyerPhoneTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: buyerPhoneController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "주문자 휴대전화",
        ),
      ),
    );
  }

  Widget receiverNameTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: receiverNameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "받는 사람 이름",
        ),
      ),
    );
  }

  Widget receiverPhoneTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: receiverPhoneController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "받는 사람 휴대 전화",
        ),
      ),
    );
  }

  Widget receiverZipTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: receiverZipController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "우편번호",
        ),
      ),
    );
  }

  Widget receiverAddress1TextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: receiverAddress1Controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "기본 주소",
        ),
      ),
    );
  }

  Widget receiverAddress2TextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: receiverAddress2Controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "상세 주소",
        ),
      ),
    );
  }

  Widget userPwdTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: userPwdController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "비회원 주문조회 비밀번호",
        ),
      ),
    );
  }

  Widget userConfirmPwdTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: userConfirmPwdController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "비회원 주문조회 비밀번호 확인",
        ),
      ),
    );
  }

  Widget cardNoTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: cardNoController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "카드번호",
        ),
      ),
    );
  }

  Widget cardAuthTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: cardAuthController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "카드명의자 주민번호 앞자리",
        ),
      ),
    );
  }

  Widget cardExpiredDateTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: cardExpiredDateController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "카드 만료일",
        ),
      ),
    );
  }

  Widget cardPwdTwoDigitsTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: cardPwdTwoDigitsController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: "카드 비밀번호 앞2자리",
        ),
      ),
    );
  }
}