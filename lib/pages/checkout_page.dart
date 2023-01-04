import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  static String routeName = "/checkout";
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(),
        body: CustomScrollView(
          slivers: [],
        ));
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      centerTitle: true,
      title: const Text(
        "Checkout",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
