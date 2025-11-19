import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/models/shoe.dart';
import 'package:my_ecommerce_app/pages/visa_payment_page.dart';
import 'package:provider/provider.dart';
import 'package:my_ecommerce_app/models/cart.dart';
import 'package:url_launcher/url_launcher.dart'; //link app to phone dialer




class CartManager extends ChangeNotifier{
  //list holding shoes added to cart
  List<Shoe> _cartItems = [];

  //access items from outside class
  List<Shoe> get cartItems => _cartItems;

  void addItem(Shoe shoe){
    _cartItems.add(shoe);
    notifyListeners();
  }
  void removeItem(Shoe shoe){
    _cartItems.remove(shoe);
    notifyListeners();
  }

}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}
  class _CheckoutPageState extends State<CheckoutPage>{
  String _selectedPaymentMethod = "Visa ending 2323";

  final List<String> paymentMethods = const [
    'Visa ending 2323',
    'MTN mobile money',
    'Airtel mobile money'
  ];

  //phone dialer
  Future<void>_launchDialer(String ussdCode) async{
    final Uri launchUri  = Uri(
      scheme: "tel",
      path: ussdCode,
    );
    if(await canLaunchUrl(launchUri)){
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Could not launch $launchUri")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    //observe cartmanager for changes
    final cart = Provider.of<Cart>(context);

    //dynamic subtotal
    double subtotal = cart.calculateTotal();
    double shippingCost = 2500.00;
    double total = subtotal + shippingCost;

    //format numbers
    String formattedSubtotal = subtotal.toStringAsFixed(2);
    String formattedShipping = shippingCost.toStringAsFixed(2);
    String formattedTotal = total.toStringAsFixed(2);

    final List<Shoe> cartItems = cart.userCart;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        titleTextStyle: TextStyle(
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 24,
        ),
        backgroundColor: Colors.grey[200],
        title: Text(
            "Checkout",
          textAlign: TextAlign.center,
        ),


      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildSectionTitle("Shipping information"),
            _buildShipping(),
            const SizedBox(height: 20,),



            _buildSectionTitle("Order summary"),
            _buildOrderSummaryCard(
              formattedSubtotal,
              formattedShipping,
              formattedTotal,
            ),
            const SizedBox(height: 20,),

            _buildSectionTitle("Payment Method"),
            _buildPaymentMethodSelector(),
            const SizedBox(height: 30,),

            _buildTotalSection(),
          ],
        ),
      ),


//button
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding : const EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Processing Order..."),
                  ),
              );
              final selectedMethod = _selectedPaymentMethod;
              if (selectedMethod.contains('Visa ending 2323')){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => VisaPaymentPage()),
                );
              }
              else if (selectedMethod.contains("MTN mobile Money")){
                _launchDialer("*162*1*1#");

              }
              else if (selectedMethod.contains("Airtel mobile Money")){
                _launchDialer("*185*1*1#");

              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(20),
              child: Text(
                  "Confirm Order",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
        
                ),
        
              ),
            ),
          ),
        ),
      ),
      
    );

  }
  Widget _buildSectionTitle(String title){
    return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
          title,
        style:  const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  Widget _buildShipping(){
    return Card(
      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),

        child: Padding(
            padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("mel"),
              Text("namugongo"),
              Text("Uganda"),
              SizedBox(height: 10,),
              Text(
                  "Change Address",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildOrderSummaryCard(
      String formattedSubtotal,
      String formattedShipping,
      String formattedTotal ){
    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildPriceRow("Shoe", "Nike Air Max"),
              _buildPriceRow("Subtotal", "shs$formattedSubtotal"),
              _buildPriceRow("Shipping", "shs$formattedShipping"),
              Divider(),
              _buildPriceRow("Total", "shs$formattedTotal", isTotal: true),
            ],

          ),
        ),
      ),
    );
  }
  Widget _buildPriceRow(String label, String value, {bool isTotal =false }){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold :FontWeight.normal,
              fontSize: isTotal ? 18: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold: FontWeight.normal,
              fontSize:  isTotal ? 18:16,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildPaymentMethodSelector(){
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: ListTile(
          leading: const Icon(Icons.payment),
          title:  Text(_selectedPaymentMethod),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16,),
          onTap: (){
            _showPaymentMethodSheet(context);
          },
        ),
      ),
    );
  }

  void _showPaymentMethodSheet(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Select Payment Method",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),

                ...paymentMethods.map((method)
          {
            return RadioListTile(
              title: Text(method),
              value: method,
              groupValue: _selectedPaymentMethod,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedPaymentMethod = newValue;
                  });
                  Navigator.pop(context);
                }
              },
              activeColor: Colors.black,
            );
          },
          ).toList(),
          ],
            ),
          );
        }
        );
  }
  Widget _buildTotalSection(){
    //return const SizedBox.shrink();
    return Container();
  }
}

