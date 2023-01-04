import 'package:flutter/material.dart';
import 'package:flutter_2_advanced/pages/checkout_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: appBar(),
      body: Stack(
        children: <Widget>[
          sectionProducts(),
          floatingCheckoutButton(context),
        ],
      ),
    );
  }

  AppBar appBar() => AppBar(
        backgroundColor: Colors.grey.shade200,
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
                fontWeight: FontWeight.w400,
                letterSpacing: 2,
                fontSize: 12,
                color: Colors.grey.shade600),
          )
        ]),
      );

  Widget sectionProducts() => GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 100),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 5,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16),
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber,
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://media-assets.lacucinaitaliana.it/photos/61faedbf9a137a03216d9230/master/pass/carbonarachallenge2.jpg"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Pasta alla carbonara",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                "7€",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(
                height: 4,
              ),
              MaterialButton(
                onPressed: () {},
                minWidth: double.infinity,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Colors.black12)),
                child: const Text('Aggiungi'),
              ),
            ],
          ),
        ),
      );

  Widget floatingCheckoutButton(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 32,
      child: MaterialButton(
        elevation: 0,
        onPressed: () {
          Navigator.pushNamed(context, CheckoutPage.routeName);
        },
        minWidth: double.infinity,
        height: 50,
        color: Colors.yellow.shade700,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text('Completa l\'acquisto (2)'),
      ),
    );
  }
}
