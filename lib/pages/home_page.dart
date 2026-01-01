import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/components/bottom_nav_bar.dart';
import 'package:my_ecommerce_app/pages/intro_page.dart';

import 'cart_page.dart';
import 'shop_page.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //selected index is to control bottom navbar
  int _selectedIndex = 0;
  //this method will update our selected index
  //when the user taps on the bottom bar
  void navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    //shop page
    const ShopPage(),

    //cart page
     const CartPage(backgroundColor:Colors.grey ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        title: Text(
            "Hype Sneakers",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
              icon: const Padding(
                padding:  EdgeInsets.only(left: 12.0),
                child:  Icon(
                    Icons.menu,
                  color: Colors.black,
                ),
              ),
              onPressed: (){
                Scaffold.of(context).openDrawer();
                },
            ),
        ),

        ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            //logos
            DrawerHeader(child: Image.asset(
              "assets/images/logo.jpg",
            ),
            ),


            //other pages
           Padding(
             padding: EdgeInsets.only(left: 10.0),
             child: ListTile(

                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
               title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white),
                ),
               onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IntroPage(),
                      ),
                  );
               },

              ),
           ),

            const Padding(
                padding: EdgeInsets.all(10.0),
              child: ListTile(
                leading: Icon(
                    Icons.info,
                    color: Colors.white,
                ),

                title: Text(
                  "About",
                  style: TextStyle(
                      color: Colors.white,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop(); // Close the drawer first

                  //  Alert Dialog
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Log Out"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          child: const Text("Log Out"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            // Add logout logic here
                            // Example:
                            // Navigator.pushReplacementNamed(context, '/login');
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            )



          ],
        ),
      ),
      body: _pages[_selectedIndex],
      );


  }
}
