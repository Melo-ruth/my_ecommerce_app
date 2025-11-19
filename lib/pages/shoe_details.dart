import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/shoe.dart';
import 'package:my_ecommerce_app/models/cart.dart';
import 'package:provider/provider.dart';

class ShoeDetailsPage extends StatefulWidget {
  final Shoe shoe;
  const ShoeDetailsPage({super.key, required this.shoe});

  @override
  State<ShoeDetailsPage> createState() => _ShoeDetailsPageState();
}

class _ShoeDetailsPageState extends State<ShoeDetailsPage> {
  bool isWishlisted = false;
  @override
  Widget build(BuildContext context) {
    final shoe = widget.shoe;

    return Scaffold(
      appBar: AppBar(
        title: Text(shoe.name),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions:[
          IconButton(
            icon: Icon(
              isWishlisted ? Icons.favorite: Icons.favorite_border,
              color: isWishlisted ? Colors.red : Colors.black,
            ),
            onPressed: (){
              setState(() {
                isWishlisted = !isWishlisted;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              color: Colors.grey[200],
              child: Image.asset(
                shoe.imagePath,
                fit: BoxFit.contain,
              )
            )
          ],
        )
      )
    );
  }
}
