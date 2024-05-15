import 'package:flutter/material.dart';

class ItemOrderResultPage extends StatefulWidget {
  const ItemOrderResultPage({super.key});

  @override
  State<ItemOrderResultPage> createState() => _ItemOrderResultPageState();
}

class _ItemOrderResultPageState extends State<ItemOrderResultPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("주문완료"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
