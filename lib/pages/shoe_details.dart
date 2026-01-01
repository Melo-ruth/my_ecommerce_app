import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/shoe.dart';
import 'package:my_ecommerce_app/models/cart.dart';
import 'package:my_ecommerce_app/pages/cart_page.dart';
import 'package:palette_generator_master/palette_generator_master.dart';
import 'package:provider/provider.dart';

class ShoeDetailsPage extends StatefulWidget {
  final Shoe shoe;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ShoeDetailsPage({
    super.key,
    required this.shoe,
    this.onTap,
    this.onAddToCart,

  });

  @override
  State<ShoeDetailsPage> createState() => _ShoeDetailsPageState();
}

class _ShoeDetailsPageState extends State<ShoeDetailsPage> {
  bool isWishlisted = false;
  int quantity = 1;
  Color _backgroundColor = Colors.white;

  @override
  void initState(){
    super.initState();
    updatebackgroundColor();
  }

  //to blend with dominant color
  Future<void>updatebackgroundColor() async{
    final PaletteGeneratorMaster generator = await PaletteGeneratorMaster.fromImageProvider(
      AssetImage(widget.shoe.imagePath),
      size: Size(100, 100),
    );
    setState(() {
      _backgroundColor = generator.dominantColor?.color ?? Colors.white;
    });
}


  void increaseQuantity(){
    setState(() {
      quantity++;
    });
  }

  void decreaseQuantity(){
    setState(() {
      if(quantity > 1){
        quantity--;
      }
    });
  }

  void toggleWishList(){
    setState(() {
      isWishlisted = !isWishlisted;
    });
  }
  void navigateToCartPage(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CartPage(
              backgroundColor: _backgroundColor,
            )
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shoe = widget.shoe;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: Text(
            shoe.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions:[
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite: Icons.favorite_border,
              color: isWishlisted ? Colors.red : Colors.black,
            ),
            onPressed: toggleWishList,
          ),

          IconButton(
              onPressed: navigateToCartPage,
              icon: Icon(Icons.shopping_cart),

          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Image.asset(
               widget.shoe.imagePath,
             height: 450,
             width: double.infinity,
             fit: BoxFit.cover,
           ),
            Padding(
                padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //details of product
                  Text(
                      widget.shoe.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
                          "Integer convallis pharetra dui, vel consectetur dui faucibus vel"
                          "Fusce id dictum neque. Mauris ac turpis suscipit, malesuada mauris id, consectetur lorem. Phasellus nec diam magna"
                          "Morbi bibendum vulputate est, at elementum sapien ultrices sed"
                  ),
                  SizedBox(height: 4,),
                  Text(widget.shoe.description),
                  SizedBox(height: 24,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                         "Quantity:",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: decreaseQuantity,
                              icon: Icon(Icons.remove_circle_outline),
                          ),
                          Text(
                            "$quantity",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          IconButton(
                              onPressed: increaseQuantity, 
                              icon: Icon(Icons.add_circle_outline)
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
            onTap: () {
              Provider.of<Cart>(context, listen: false).addItemToCart(widget.shoe, quantity: quantity);
              //Navigator.push(
                  //context,
                  //MaterialPageRoute(builder: (context)=>),
              //);
              //print("Added $quantity of ${widget.shoe.name}to cart.");
              ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Added to Cart!")),
              );
            },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.black, // button color
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),

            child: Text(
              "Add to Cart",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,

            ),

        ),
      ),
    ),
    );
  }
}
