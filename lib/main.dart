import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/cart.dart';
import 'package:my_ecommerce_app/pages/checkout_page.dart';
import 'package:my_ecommerce_app/pages/intro_page.dart';
import 'package:provider/provider.dart';
//mport 'package:my_ecommerce_app/intro_page.dart';




void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Cart()),
        ],
        child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Put the provider HERE, wrapping the MaterialApp ---
    return ChangeNotifierProvider<Cart>(
      create: (context) => Cart(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
        ), // Your app starts here
      );

  }
}


