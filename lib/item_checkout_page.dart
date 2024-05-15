import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingmall/item_order_result_page.dart';
import 'package:shoppingmall/models/product.dart';
import 'constants.dart';
import 'package:kpostal/kpostal.dart';
import 'package:shoppingmall/components/basic_dialog.dart';

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

  final formKey = GlobalKey<FormState>();

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
  TextEditingController depositNameController = TextEditingController();

  // 결제수단 옵션 선택 변수
  final List<String> paymentMethodList = [
    '결제수단선택',
    '카드결제',
    '무통장입금',
  ];

  String selectedPaymentMethod = "결제수단선택";

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
            Form(
              key: formKey,
              child: Column(
                children: [
                  inputTextField(
                      currentController: buyerNameController,
                      currentHintText: "주문자명"),
                  inputTextField(
                      currentController: buyerEmailController,
                      currentHintText: "주문자 이메일"),
                  inputTextField(
                      currentController: buyerPhoneController,
                      currentHintText: "주문자 휴대전화"),
                  inputTextField(
                      currentController: receiverNameController,
                      currentHintText: "받는 사람 이름"),
                  inputTextField(
                      currentController: receiverPhoneController,
                      currentHintText: "받는 사람 휴대 전화"),

                  receiverZipTextField(),

                  inputTextField(
                      currentController: receiverAddress1Controller,
                      currentHintText: "기본 주소",
                      isReadOnly: true),
                  inputTextField(
                      currentController: receiverAddress2Controller,
                      currentHintText: "상세 주소"),
                  inputTextField(
                      currentController: userPwdController,
                      currentHintText: "비회원 주문조회 비밀번호",
                      isObscure: true),
                  inputTextField(
                      currentController: userConfirmPwdController,
                      currentHintText: "비회원 주문조회 비밀번호 확인",
                      isObscure: true),

                  paymentMethodDropdownButton(),

                  if (selectedPaymentMethod == "카드결제")
                    Column(
                      children: [
                        inputTextField(
                            currentController: cardNoController,
                            currentHintText: "카드번호"),
                        inputTextField(
                            currentController: cardAuthController,
                            currentHintText: "카드명의자 주민번호 앞자리 또는 사업자번호",
                            currentMaxLength: 10),
                        inputTextField(
                            currentController: cardExpiredDateController,
                            currentHintText: "카드 만료일 (YYYYMM)",
                            currentMaxLength: 6),
                        inputTextField(
                            currentController: cardPwdTwoDigitsController,
                            currentHintText: "카드 비밀번호 앞2자리",
                            currentMaxLength: 2),
                      ],
                    ),
                  if (selectedPaymentMethod == "무통장입금")
                    inputTextField(
                        currentController: depositNameController,
                        currentHintText: "입금자명"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              if (selectedPaymentMethod == "결제수단선택") {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (context) {
                      return BasicDialog(
                        content: "결제수단을 선택해 주세요.",
                        buttonText: "닫기",
                        buttonFunction: () => Navigator.of(context).pop(),
                      );
                    });
                  return;
                }
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return const ItemOrderResultPage();
                },
              ));
            }
          },
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

  Widget inputTextField({
    required TextEditingController currentController,
    required String currentHintText,
    int? currentMaxLength,
    bool isObscure = false,
    bool isReadOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if(value!.isEmpty) {
            return "내용을 입력해 주세요.";
          } else {
            if (currentController == userConfirmPwdController && userPwdController.text != userConfirmPwdController.text) {
              return "비밀번호가 일치하지 않습니다";
            }
          }
          return null;
        },
        controller: currentController,
        maxLength: currentMaxLength,
        obscureText: isObscure,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: currentHintText,
        ),
      ),
    );
  }

  Widget receiverZipTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              readOnly: true,
              controller: receiverZipController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "우편번호",
              ),
            ),
          ),
          const SizedBox(width: 15),
          FilledButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return KpostalView(
                          callback: (Kpostal result) {
                            receiverZipController.text = result.postCode;
                            receiverAddress1Controller.text = result.address;
                          },
                        );
                      },
                   ));
              },
              style:  FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 22),
                child: Text("우편 번호 찾기"),
              ),
          ),
        ],
      ),
    );
  }

  Widget paymentMethodDropdownButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        value: selectedPaymentMethod,
        onChanged: (value) {
          setState(() {
            selectedPaymentMethod = value ?? "";
          });
        },
        isExpanded: true,
        underline: Container(),
        items: paymentMethodList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}