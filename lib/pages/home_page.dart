import 'package:flutter/material.dart';
import 'package:flutter_2_advanced/bloc/shopping_cart_bloc.dart';
import 'package:flutter_2_advanced/pages/checkout_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    //*All'init della Home page genero evento INIT del bloc
    //*che farà generare l'evento LOADING aspetta 2 s
    //*e poi genera l'evento LOADED passandogli la lista di prodotti (hard-coded)
    BlocProvider.of<ShoppingCartBloc>(context)
        .add(ShoppingCartBlockEventInit());
  }

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

  Widget sectionProducts() =>
      BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
          builder: (context, state) {
        if (state is ShoppingCartBlocStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          //*PRENDO DAL BLOC CHE SO CHE ORMAI è LOADED

          final products = (state as ShoppingCartBlocStateLoaded).products;
          return GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 32, 16, 100),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 3 / 5,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16),
            itemCount: products.length,
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber,
                        image: DecorationImage(
                            image: NetworkImage(products[index].imageUrl),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    products[index].name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "€ ${products[index].price.toStringAsFixed(2)}",
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
                    child: Text(
                        products[index].nelCarrello ? "Rimuovi" : "Aggiungi"),
                  ),
                ],
              ),
            ),
          );
        }
      });

  Widget floatingCheckoutButton(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartBlocState>(
        builder: (context, state) {
      if (state is ShoppingCartBlocStateLoading) {
        return const SizedBox(); //*NON MOSTRO NULLA
      } else {
        //* recupero i prodotti
        final products = (state as ShoppingCartBlocStateLoaded).products;
        final productsNelCarrello = products.where(
          (element) => element.nelCarrello,
        );
        if (productsNelCarrello.isEmpty) {
          return const SizedBox(); //*non mostro nulla
        } else {
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
              child:
                  Text('Completa l\'acquisto (${productsNelCarrello.length})'),
            ),
          );
        } // nel carrello ci sono prodotti
      } // is loaded
    });
  }
}
