import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/firebase_options.dart';
import 'package:my_ecommerce_app/models/cart.dart';
import 'package:my_ecommerce_app/pages/checkout_page.dart';
import 'package:my_ecommerce_app/pages/intro_page.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => Cart(),
          ),
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
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
        ); // Your app starts here

  }
}


