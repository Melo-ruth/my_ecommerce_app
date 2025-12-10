import 'package:flutter/cupertino.dart';
import 'package:my_ecommerce_app/models/shoe.dart';

class Cart extends ChangeNotifier{

  //list of shoes for sale
  List<Shoe>shoeShop = [
    Shoe(
        name: "Air max",
        price: "150,000",
        imagePath: "assets/images/shoes2.jpg",
        description: "size 40",
    ),
    Shoe(
        name: "Nike Men's Air ",
        price: "350,000",
        imagePath: "assets/images/shoes3.jpg",
        description: "size 46",
    ),
    Shoe(
        name: "KD Treys",
        price: "200,000",
        imagePath: "assets/images/shoes1.jpg",
        description: "Size 39",
    ),
    Shoe(
        name: "Nike React",
        price: "350,000",
        imagePath: "assets/images/shoes4.jpg",
        description: "size 43",
    ),

  ];

  //list of items in user cart
List<Shoe>userCart = [];

double calculateTotal(){
  double totalPrice = 0;

  for (Shoe shoe in userCart){
    String cleanPrice = shoe.price.replaceAll(",", "");
    totalPrice += double.parse(cleanPrice);
    double itemPrice = double.parse(cleanPrice);
    totalPrice += itemPrice * shoe.quantity;
  }
  return totalPrice;
}


  //get list of shoes for sale
List<Shoe>getShoeList(){
  return shoeShop;
}
  //get cart
List<Shoe>getUserCart(){
  return userCart;
}
  //add items to cart
void addItemToCart(Shoe shoe , {int quantity =1}){
  //if item is in cart
  for (var item in userCart){
    if (item.name == shoe.name){
      item.quantity += quantity;
      notifyListeners();
      return;
    }
  }

  Shoe newShoe = Shoe(
      name: shoe.name,
      price: shoe.price,
      imagePath: shoe.imagePath,
      description: shoe.description,
  );



  userCart.add(shoe);
  notifyListeners();
}
  //remove items from cart
  void removeItemFromCart(Shoe shoe){
    userCart.remove(shoe);
    notifyListeners();
  }



}
