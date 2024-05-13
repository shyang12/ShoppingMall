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
│   ├── UserDTO.kt
│   └── VideoActivity.kt
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
│    ├── channel
│    └── email

```

## 4. Result
