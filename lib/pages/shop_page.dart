import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/cart.dart';
import 'package:my_ecommerce_app/models/shoe.dart';
import 'package:provider/provider.dart';

import '../components/shoe_tile.dart';
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {

  //add shoe to cart
  void addShoeToCart(Shoe shoe){
    Provider.of<Cart>(context, listen: false).addItemToCart(shoe);
    
    //alert user , shoe successfully added
    showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Successfully added!"),
          content: Text("check your cart"),

        ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, value, child) => Column(
          children: [
            //search bar
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              decoration: BoxDecoration(color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search',
                      style: TextStyle(color: Colors.grey)
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),

                ],
              ),
            ),

            //messages
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Don't wait for stock to run out",
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),

            //hot picks
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const[
                  Text(
                    'Hot Picks 🔥',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "see all",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),


            const SizedBox(height: 20),

            //list of shoes for sale
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder:(context, index){
                  //create a shoe
                  Shoe shoe = value.getShoeList()[index];

                  return ShoeTile(
                    shoe: shoe,
                    onTap: () => addShoeToCart(shoe),
                  );
                },
              ),
            ),
            const Padding(
              padding:  EdgeInsets.only(top: 25.0, left: 25, right: 25),
              child: Divider(
                color: Colors.white,
              ),

            ),
          ],
        )
    );
  }
}
