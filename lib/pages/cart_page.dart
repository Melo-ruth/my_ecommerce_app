import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/cart.dart';
import 'package:my_ecommerce_app/models/shoe.dart';
import 'package:my_ecommerce_app/pages/checkout_page.dart';
import 'package:provider/provider.dart';

import '../components/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, value, child) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //heading
          const Text(
            'My Cart',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,

            ),
          ),

           const SizedBox(height: 20),

          Expanded(child: ListView.builder(
            itemCount: value.getUserCart().length,
              itemBuilder: (context, index) {
                //get individial shoe
                Shoe individualShoe = value.getUserCart()[index];

                //returns the cart
                return CartItem(
                  shoe: individualShoe,
                );
              }
          ),
          ),
          const SizedBox(height: 25,),

          //proceed to checkout button
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutPage()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              child: const Center(
                child: Text(
                  "Proceed to checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
        ],

      ),
    ));
  }
}
