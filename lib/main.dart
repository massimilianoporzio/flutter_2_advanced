import 'package:flutter/material.dart';
import 'package:flutter_2_advanced/bloc/shopping_cart_bloc.dart';
import 'package:flutter_2_advanced/pages/checkout_page.dart';
import 'package:flutter_2_advanced/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ShoppingCartBloc(),
    )
  ], child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        CheckoutPage.routeName: (context) => const CheckoutPage(),
      },
    );
  }
}
