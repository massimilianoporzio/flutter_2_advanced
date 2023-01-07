import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  static String routeName = "/checkout";
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: appBar(),
        body: CustomScrollView(
          slivers: [sectionProductList(), sectionCostRecap()],
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

  Widget sectionProductList() => SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 4),
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://media-assets.lacucinaitaliana.it/photos/61faedbf9a137a03216d9230/master/pass/carbonarachallenge2.jpg"),
                    ),
                    title: Text(
                      "Pasta alla carbonara",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("€ 7.00"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.remove_circle_outline),
                    ),
                  ),
                ),
            childCount: 3),
      );

  Widget sectionCostRecap() {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        const CheckoutRow(
          text: "Sottototale",
          value: 7.0,
        ),
        const CheckoutRow(
          text: "Tasse",
          value: 1.414,
        ),
        ListTile(
          dense: true,
          title: Text(
            "Totale",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Text(
            "€ 8.40",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: MaterialButton(
            elevation: 0,
            onPressed: () {},
            minWidth: double.infinity,
            height: 50,
            color: Colors.yellow.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text('Acquista'),
          ),
        ),
      ],
    ));
  }
}

class CheckoutRow extends StatelessWidget {
  final String text;
  final double value;

  const CheckoutRow({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(
        text,
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      ),
      trailing: Text(
        "€ ${value.toStringAsFixed(2)}",
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}
