# ShoppingMall App
## ▶ 안드로이드 스튜디오 쇼핑몰앱 만들기 (Flutter -> dart)
 
 - 안드로이드 스튜디오에서 Flutter(dart)를 기반으로 쇼핑몰 앱을 구현하는 프로젝트

`kpostal (우편주소 API)` `Firebase` `Firestore Database`

# ▶ PG 결제 시스템, 배송 조회등 기능 뺴고 구현

## 1. Co-Development Environment   
### 1. 1 Environments
- Windows 10
- Android Studio / Flutter / Dart
- Firebase
- GitHub

### 1. 2 Driving
- Android
- IOS
- WEB
- Window

### 1. 3 Implement
- 상품 리스트를 ScrollView를 통해 상품 사진, 상품명, 가격등 정보 제공 -> `나의 주문목록, 장바구니 확인 버튼 위에 추가`
- 제품의 상세 페이지를 통해 제품의 상세 내용 제공
- 장바구니 기능을 통해 상품 개수 추가 or 감소, 삭제등 구매하기 전 장바구니 기능
- 우편번호(주소) API를 사용하여 사용자에게 택배 보낼 주소 저장 기능
- 주문목록에서 주문날짜, 주분정보, 주문취소, 배송조회등의 기능
- 주문완료 페이지를 통해 최종 결제

## 2. Project Architecture   
```bash
├── main
│   ├── main.dart
│   ├── item_list_page.dart
│   ├── item_details_page.dart
│   ├── item_basket_page.dart
│   ├── item_checkout_page.dart
│   ├── item_order_result_page.dart
│   ├── my_order_list_page.dart
│   └── constants.dart
├── model
│   ├── product.dart
├── components
│   ├── basic_dialog.dart
├── enums
│   ├── delivery_status.dart
│   └── payment_status.dart
```

## 3. Firebase   
### 3.1 Authentication

### 3.2 Firestore Database
```bash
├── orders
│    ├── buyerEmail
│    ├── buyerName
│    ├── buyerPhone
│    ├── deliveryStatus
│    ├── orderDate
│    ├── orderNo
│    ├── paymentMethod
│    ├── paymentStatus
│    ├── productNo
│    ├── quantity
│    ├── receiverAddress1
│    ├── receiverAddress2
│    ├── receiverName
│    ├── receiverPhone
│    ├── receiverZip
│    ├── totalPrice
│    ├── unitPrice
│    └── userPwd
├── products
│    ├── price
│    ├── productImageUrl
│    ├── productName
│    └── productNo
```

## 4. Result
- 제품 리스트 페이지

![제품리스트](https://github.com/shyang12/ShoppingMall/assets/85710913/7b9fb0da-a6e5-4a52-bec0-85ba46766979)


- 제품 상세 페이지

![제품 상세](https://github.com/shyang12/ShoppingMall/assets/85710913/d6a00a21-49c7-4d1d-a54a-9287518b224b)


- 장바구니 페이지

![장바구니](https://github.com/shyang12/ShoppingMall/assets/85710913/849f9d7b-eb4e-441c-b5ca-c5e4ab729b48)


- 결제시작 페이지

![결제시작](https://github.com/shyang12/ShoppingMall/assets/85710913/6884b830-3516-477e-af55-85a29d4adb80)    ![결제수단 상세](https://github.com/shyang12/ShoppingMall/assets/85710913/11f6be4e-fad1-4619-9e92-dbc539ed4e67)


- 주소 검색 API 추가

![주소 검색](https://github.com/shyang12/ShoppingMall/assets/85710913/a484eeec-b3a3-4226-b425-d941482d0db7)

- 주문완료 페이지

![주문완료](https://github.com/shyang12/ShoppingMall/assets/85710913/1f160e00-a96a-41a4-beab-994c417a720d)

- 나의 주문목록 페이지

![주문목록](https://github.com/shyang12/ShoppingMall/assets/85710913/56719794-f48d-4fa9-84a7-7367aa98324d)
