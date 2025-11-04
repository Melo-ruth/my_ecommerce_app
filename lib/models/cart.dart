import 'package:flutter/cupertino.dart';
import 'package:my_ecommerce_app/models/shoe.dart';

class Cart extends ChangeNotifier{

  //list of shoes for sale
  List<Shoe>shoeShop = [
    Shoe(
        name: "Air max",
        price: "150,000",
        imagePath: "assets/images/shoes2.jpg",
        description: "size 40"
    ),
    Shoe(
        name: "Nike Men's Air ",
        price: "350,000",
        imagePath: "assets/images/shoes3.jpg",
        description: "size 46"
    ),
    Shoe(
        name: "KD Treys",
        price: "200,000",
        imagePath: "assets/images/shoes1.jpg",
        description: "Size 39"
    ),
    Shoe(
        name: "Nike React",
        price: "350,000",
        imagePath: "assets/images/shoes4.jpg",
        description: "size 43"
    ),

  ];

  //list of items in user cart
List<Shoe>userCart = [];

  //get list of shoes for sale
List<Shoe>getShoeList(){
  return shoeShop;
}
  //get cart
List<Shoe>getUserCart(){
  return userCart;
}
  //add items to cart
void addItemToCart(Shoe shoe){
  userCart.add(shoe);
  notifyListeners();
}
  //remove items from cart
  void removeItemFromCart(Shoe shoe){
    userCart.remove(shoe);
    notifyListeners();
  }


}
