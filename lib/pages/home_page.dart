import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: appBar(),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        centerTitle: true,
        title: Column(children: [
          const Text(
            'LUIGI\'S',
            style: TextStyle(
                letterSpacing: 2,
                fontWeight: FontWeight.w900,
                color: Colors.black),
          ),
          Text(
            'Spedizione gratuita per ordini > 50€',
            style: TextStyle(
                letterSpacing: 2, fontSize: 12, color: Colors.grey.shade600),
          )
        ]),
      );
}
