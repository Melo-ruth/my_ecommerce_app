import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/cart.dart';
import 'package:my_ecommerce_app/models/shoe.dart';
import 'package:my_ecommerce_app/pages/shoe_details.dart';
import 'package:provider/provider.dart';

import '../components/shoe_tile.dart';
class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool isDark = false;
  TextEditingController searchController = TextEditingController();
  String query = "";


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
  //class _MySearchbar extends State<ShopPage>


  
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, value, child){
          final shoeList = value.getShoeList();

          final results = shoeList
          .where((shoe) =>
              shoe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                //search bar
                Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value){
                      setState(() => query = value);
                      },
                    decoration: InputDecoration(
                      prefixIcon:  const Icon(Icons.search, color:  Colors.grey,),
                      hintText:  "Search shoes...",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                if (query.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: results.length,
                      itemBuilder: (context, index){
                      final shoe = results[index];

                      return ListTile(
                        leading: Image.asset(shoe.imagePath, width: 45,),
                        title: Text(shoe.name),
                        subtitle: Text("Ugx ${shoe.price}"),
                        onTap: (){
                          setState(() {
                            query = "";
                            searchController.clear();
                          });
                          FocusScope.of(context).unfocus();

                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ShoeDetailsPage(shoe: shoe)),
                          );
                        });
                      }
                  ),

                /**SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return Container(
                      width: 360,
                      child: SearchBar(
                        controller: controller,
                        padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onTap: () {
                          controller.openView();
                        },
                        onChanged: (_) {
                          controller.openView();
                        },
                        leading: const Icon(
                            Icons.search,
                            color: Colors.grey
                        ),
                        backgroundColor: WidgetStatePropertyAll<Color>(
                            Colors.grey[100]!
                        ),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    );
                  },
                  suggestionsBuilder: (BuildContext context, SearchController controller) {
                    //get list of shoes
                    final shoeList = Provider.of<Cart>(context,listen:false).getShoeList();

                    //filter shoe based on user
                    final query = controller.text.toLowerCase();
                    final results = shoeList
                        .where((shoe) => shoe.name.toLowerCase().contains(query))
                        .toList();

                    return List<ListTile>.generate(results.length, (int index) {
                      final shoe = results[index];
                      return ListTile(
                        title: Text(shoe.name),
                        onTap: () {
                          controller.closeView(shoe.name);

                        },
                      );
                    });
                  },
                ),**/

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


                //const SizedBox(height: 20),

                //list of shoes for sale
                SizedBox(
                  height: 425,
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
                  //child: Divider(
                  //color: Colors.white,
                  //),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.getShoeList().length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.8,
                      ),

                      itemBuilder: (context, index){
                        Shoe shoe = value.getShoeList()[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: AssetImage(shoe.imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //Image.asset(
                                  //shoe.imagePath,
                                  //height: 80,
                                  //fit: BoxFit.cover,
                               // ),


                                SizedBox(height: 10,),
                                Expanded(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 10,
                                            left: 10,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(shoe.name, style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                                Text("Ugx" + shoe.price),

                                SizedBox(height: 15,),
                                //button
                                GestureDetector(
                                  onTap: () => addShoeToCart(shoe),
                                  child: Container(
                                    //height: 50,
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(15),
                                          topRight: Radius.circular(12),
                                          bottomLeft: Radius.circular(12)
                                      ),

                                    ),

                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                      //size: 25,

                                    ),
                                  ),
                                ),
                              ],
                            ),
                                    ),

                          ],
                        ),
                                ),
                         ]
                        ),
                          ),
                        );

                      }
                  ),
                ),
                SizedBox(height: 20,),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.0,
                  height: 1.0,
                ),
                SizedBox(height: 10,),
              ],
            ),
          );
        },
    );
  }
}