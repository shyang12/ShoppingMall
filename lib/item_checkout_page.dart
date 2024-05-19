import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:shoppingmall/item_order_result_page.dart';
import 'package:shoppingmall/models/product.dart';
import 'constants.dart';
import 'package:kpostal/kpostal.dart';
import 'package:shoppingmall/components/basic_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums/delivery_status.dart';
import 'enums/payment_status.dart';
import 'models/order.dart';

class ItemCheckoutPage extends StatefulWidget {
  const ItemCheckoutPage({super.key});

  @override
  State<ItemCheckoutPage> createState() => _ItemCheckoutPageState();
}

class _ItemCheckoutPageState extends State<ItemCheckoutPage> {
  final database = FirebaseFirestore.instance;

  Query<Product>? productListRef;

  double totalPrice = 0;
  Map<String, dynamic> cartMap = {};
  Stream<QuerySnapshot<Product>>? productList;
  List<int> keyList = [];

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
    try {
      cartMap =
          json.decode(sharedPreferences.getString("cartMap") ?? "{}") ?? {};
    } catch (e) {
      debugPrint(e.toString());
    }

    // 조건문에 넘길 product no 키 값 리스트를 선언
    cartMap.forEach((key, value) {
      keyList.add(int.parse(key));
    });

    // 파이어스토어에서 데이터 가져오는 Ref 변수
    if (keyList.isNotEmpty) {
      productListRef = database.collection("products")
          .withConverter(fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => product.toJson())
          .where("productNo", whereIn: keyList);
    }

    productList = productListRef?.orderBy("productNo").snapshots();
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
            if (cartMap.isNotEmpty)
            StreamBuilder(
                stream: productList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((document) {
                        if (cartMap[document.data().productNo.toString()] != null) {
                          return checkoutContainer(
                              productNo: document.data().productNo ?? 0,
                              productName: document.data().productName ?? "",
                              productImageUrl: document.data().productImageUrl ?? "",
                              price: document.data().price ?? 0,
                              quantity: cartMap[document.data().productNo.toString()]);
                        }
                        return Container();
                      }).toList(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("오류가 발생했습니다."),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  }
                }),
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
      bottomNavigationBar:
          cartMap.isEmpty ? const Center(child: Text("결제할 제품이 없습니다.")) :
          StreamBuilder(
            stream: productList,
            builder: (context, snapshot) {
          if (snapshot.hasData) {
            totalPrice = 0;
            snapshot.data?.docs.forEach((document) {
              if (cartMap[document.data().productNo.toString()] != null) {
                totalPrice += cartMap[document.data().productNo.toString()] * document.data().price ?? 0;
              }
            });
            return Padding(
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

                    List<int> bytes = utf8.encode(userPwdController.text);
                    Digest hashPwd = sha256.convert(bytes);
                    String orderNo = "${DateFormat("yMdhms").format(DateTime.now())} - ${DateTime.now().millisecond}";

                    // 이 부분에 파이어스토어에 접근해서 데이터 insert 작업 진행함.
                    snapshot.data?.docs.forEach(
                          (document) {
                        ProductOrder productOrder = ProductOrder(
                          orderNo: orderNo,
                          productNo: document.data().productNo,
                          orderDate: DateFormat("y-M-d h:m:s")
                              .format(DateTime.now()),
                          buyerName: buyerNameController.text,
                          buyerEmail: buyerEmailController.text,
                          buyerPhone: buyerPhoneController.text,
                          receiverName: receiverNameController.text,
                          receiverPhone: receiverPhoneController.text,
                          receiverZip: receiverZipController.text,
                          receiverAddress1:
                          receiverAddress1Controller.text,
                          receiverAddress2:
                          receiverAddress2Controller.text,
                          userPwd: hashPwd.toString(),
                          paymentMethod: selectedPaymentMethod,
                          quantity: cartMap[
                          document.data().productNo.toString()],
                          unitPrice: document.data().price,
                          totalPrice: cartMap[document
                              .data()
                              .productNo
                              .toString()] *
                              document.data().price,
                          paymentStatus:
                          PaymentStatus.waiting.statusName,
                          deliveryStatus:
                          DeliveryStatus.waiting.statusName,
                        );
                        print(jsonEncode(productOrder));
                        try {
                          database
                              .collection("orders")
                              .add(productOrder.toJson());
                        } catch (e) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Center(
                                          child: Text("오류가 발생 했습니다.")),
                                    ],
                                  ),
                                ),
                                actions: [
                                  Center(
                                    child: FilledButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: Text("확인")),
                                  ),
                                ],
                              );
                            },
                          );
                          // 아래 부분이 더 이상 호출되지 않도록 return합니다.
                          return;
                        }
                      },
                    );

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ItemOrderResultPage(
                          paymentMethod: selectedPaymentMethod,
                          paymentAmount: totalPrice,
                          receiverName: receiverNameController.text,
                          receiverPhone: receiverPhoneController.text,
                          zip: receiverZipController.text,
                          address1: receiverAddress1Controller.text,
                          address2: receiverAddress2Controller.text,
                        );
                      },
                    ));
                  }
                },
                child: Text("총 ${numberFormat.format(totalPrice)}원 결제하기"),
              ));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("오류가 발생했습니다."),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        }
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
            height: 130,
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