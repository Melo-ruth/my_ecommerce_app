import 'package:flutter/material.dart';
import 'package:my_ecommerce_app/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Mazima Sneakers",
          style: TextStyle(
            color: Colors.grey[900],
            fontWeight: FontWeight.bold,

          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),


      body:
      Padding(
          padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "Enter your email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: "Password",

                  ),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "Please enter your password";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24.0),

                //login button
                ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()){
                      print("Logging in with ${_emailController.text} and ${_passwordController.text}");
                    }
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    foregroundColor: Colors.white,

                    padding: const EdgeInsets.all(25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                    child: Text(
                        "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                ),

                TextButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> SignupPage()),
                      );
                    },
                    child: Text("Don't have an account? Sign Up "),
                ),
              ],
            )
        ),
      ),
    );
  }
}
