import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_2_advanced/bloc/shopping_cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class CheckoutPage extends StatelessWidget {
  static String routeName = "/checkout";
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    //*metto in ascolto di un bloc

    return BlocListener<ShoppingCartBloc, ShoppingCartBlocState>(
      listener: (context, state) {
        final productsNelCarrello = (state as ShoppingCartBlocStateLoaded)
            .products
            .where((element) => element.nelCarrello)
            .toList();
        if (productsNelCarrello.isEmpty) {
          Navigator.of(context).pop(); //*torno indietro
        }
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: appBar(),
          body: CustomScrollView(
            slivers: [sectionProductList(), sectionCostRecap()],
          )),
    );
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

  Widget sectionProductList() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return Center(
            child: CircularProgressIndicator(color: Colors.amber.shade700),
          );
        } else {
          final products = (state as ShoppingCartBlocStateLoaded).products;
          final productsNelCarrello = products
              .where(
                (element) => element.nelCarrello,
              )
              .toList();
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(productsNelCarrello[index].imageUrl),
                        ),
                        title: Text(
                          productsNelCarrello[index].name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                            "€ ${productsNelCarrello[index].price.toStringAsFixed(2)}"),
                        trailing: IconButton(
                          onPressed: () {
                            BlocProvider.of<ShoppingCartBloc>(context).add(
                                ShoppingCartBlockEventToggle(
                                    product: productsNelCarrello[index]));
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                      ),
                    ),
                childCount: productsNelCarrello.length),
          );
        } //stato LOADED
      });

  Widget sectionCostRecap() {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
      builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return Center(
            child: CircularProgressIndicator(color: Colors.amber.shade700),
          );
        } else {
          final productsNelCarrello = (state as ShoppingCartBlocStateLoaded)
              .products
              .where((element) => element.nelCarrello)
              .toList();
          final subTotale = productsNelCarrello
              .map(
                (e) => e.price,
              )
              .sum;
          final tasse = subTotale * 0.22;
          final totale = subTotale + tasse;
          return SliverToBoxAdapter(
            child: Column(
              children: [
                CheckoutRow(
                  text: "Sottototale",
                  value: subTotale,
                ),
                CheckoutRow(
                  text: "Tasse",
                  value: tasse,
                ),
                ListTile(
                  dense: true,
                  title: const Text(
                    "Totale",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "€ ${totale.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
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
            ),
          );
        } //loaded
      },
    );
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
