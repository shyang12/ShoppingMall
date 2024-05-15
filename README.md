# ShoppingMall App
## ▶ 안드로이드 스튜디오 쇼핑몰앱 만들기 (Flutter -> dart)
 
 - 안드로이드 스튜디오에서 Flutter(dart)를 기반으로 쇼핑몰 앱을 구현하는 프로젝트

`DataBinding` `Firebase` `Firestore Database` `Remotemonster`

## 1. Co-Development Environment   
### 1. 1 Environments
- Windows 10
- Android Studio / Flutter / Dart
- Firebase
- GitHub

### 1. 2 Implement
- 구글 로그인을 통한 User 이메일 출력 `Firebase Authentication + Firestore Database`
- User 이메일을 터치하여 화상 채팅 수행 `Remotemonster`
- Alert를 통해 채팅방 참여 여부 결정
- Random값 (100 ~ 1000000)까지의 채널을 만들어 화상 통화방이 겹치는 것 방지

## 2. Project Architecture   
```bash
├── main
│   ├── main.dart
│   ├── item_list_page.dart
│   ├── item_details_page.dart
│   ├── item_basket_page.dart
│   ├── item_checkout_page.dart
│   ├── item_checkout_page.dart
│   ├── item_checkout_page.dart
│   ├── item_checkout_page.dart
│   └── constants.dart
├── model
│   ├── product.dart
├── UI
│   ├── layout
│   │   ├── item_person.xml
│   │   ├── activity_video.xml
│   │   ├── activity_login.xml
│   │   └── activity_main.xml
```

## 3. Firebase   
### 3.1 Authentication

### 3.2 Firestore Database
```bash
├── users
│    ├── 
│    └── 

```

## 4. Result
- 제품 리스트 페이지

![제품 리스트](https://github.com/shyang12/ShoppingMall/assets/85710913/f9597257-c7ea-4619-90ef-ffd443dad152)

- 제품 상세 페이지

![제품 상세 페이지](https://github.com/shyang12/ShoppingMall/assets/85710913/cd3fe7f3-33f5-4c11-bd7d-fc450cd73175)

- 장바구니 페이지

![장바구니](https://github.com/shyang12/ShoppingMall/assets/85710913/849f9d7b-eb4e-441c-b5ca-c5e4ab729b48)


- 결제시작 페이지

![결제시작](https://github.com/shyang12/ShoppingMall/assets/85710913/6884b830-3516-477e-af55-85a29d4adb80)

- 주소 검색 API 추가

![주소 검색](https://github.com/shyang12/ShoppingMall/assets/85710913/a484eeec-b3a3-4226-b425-d941482d0db7)

