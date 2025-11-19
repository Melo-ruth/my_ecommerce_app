import 'package:flutter/material.dart';

class VisaPaymentPage extends StatefulWidget {
  const VisaPaymentPage({super.key});

  @override
  State<VisaPaymentPage> createState() => _VisaPaymentPageState();
}
bool _isChecked = false;

class _VisaPaymentPageState extends State<VisaPaymentPage> {
  //controllers for userinput
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _processPayment(){
    if(_formKey.currentState!.validate()){
      //where to intergrate the actual payment methods

      final cardNumber = _cardNumberController.text;
      final expiry = _expiryController.text;
      final cvv = _cvvController.text;
      final name = _nameController.text;

      print("Processing payment Card: $cardNumber, Name: $name");

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Payment Successful!")),
      );
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OrderConfirmationPage()));
    }
  }

  @override
  void dispose(){
    //clean controllers
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Pay with Visa"),
        backgroundColor: Colors.grey[200],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //visa card image
              Center(
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).scaffoldBackgroundColor,
                      BlendMode.srcATop,
                    ),
                  child: Image.asset(
                    'assets/images/visa.jpg',
                    height: 100,
                  ),
                ),
              ),
              const SizedBox(height: 120),

              TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Card number",
                  hintText: "xxxx xxxx xxxx xxxx",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.credit_card),
                ),

                validator: (value){
                  if (value == null || value.isEmpty || value.length != 16){
                    return "Please enter a valid 16-digit card number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                        controller: _expiryController,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: "MM/YY",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value){
                          if (value == null || value.isEmpty|| value.length !=5){
                            return "Invalid date";
                          }
                          return null;
                        },
                      ),
                  ),
                  const SizedBox(width: 20,),

                  Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "CVV",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value){
                          if (value == null || value.isEmpty ||value.length < 3 || value.length > 4){
                            return "Invalid CVV";
                          }
                          return null;
                        },
                      )
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              TextFormField(

                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Cardholder name",
                  hintText: "Melissa meow",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
                validator: (value){
                  if (value == null || value.isEmpty){
                    return "Please enter card holder name";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 60,),


              //remember this card
              CheckboxListTile(
                title: const Text("Remember Card Number"),
                  value: _isChecked,
                  onChanged: (bool? newValue){
                  setState(() {
                    _isChecked = newValue ?? false;
                  });
                  },
                activeColor: Colors.black,
                checkColor: Colors.white,
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 40,),

              ElevatedButton(
                  onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    ),
                  ),

                  child: const Text(
                    "Pay Now",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
