import 'package:flutter/material.dart';
import 'package:my_project/home_page.dart';
import 'package:my_project/widgets/register_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_project/widgets/input_field.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  bool _isLoading = false;

  final _supabase = Supabase.instance.client;

  void login() async {
  String email = _emailController.text.trim();
  String password = _passwordController.text.trim();

  setState(() {
    _isLoading = true;
  });

  try {
    final response = await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user != null) {

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );

    }

    _emailController.clear();
    _passwordController.clear();

  } on AuthException catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.message),
      ),
    );

  }

  setState(() {
    _isLoading = false;
  });
}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
  padding: const EdgeInsets.only(top: 50),
  child:SingleChildScrollView(
  child: Center(
    child: SizedBox(
      width: 420,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(30),

            // ONLY ONE FORM
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  /// HEADER
                  Container(
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),

                    child: Column(
                      children: [

                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        const Text(
                          "Login to your account",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  

                    const SizedBox(height: 20),



                     SizedBox(height: 20),
                        InputField(
                          controller: _emailController,
                          keyboardType:TextInputType.emailAddress,
                          hintText: "Enter Email",
                          labelText: "Email",
                          prefixIcon:  Icon(Icons.email),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter email";
                            }
                            return null;
                          },
                        ),

                    SizedBox(height: 10),
                        InputField(
                          controller: _passwordController,
                          keyboardType:TextInputType.visiblePassword,
                          hintText: "Enter password",
                          labelText: "Password",
                          obscureText: true,
                          prefixIcon:  Icon(Icons.lock),
                          validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter password";
                              }
                              return null;
                            },
                            
                        ),

                    const SizedBox(height: 10),


                    const SizedBox(height: 10),

                    SizedBox(height: 10),
                     ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  login();
                                }
                              },
                        child: _isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                "Login",
                                style: TextStyle(fontSize: 18),
                              ),
                      ),
                      SizedBox(height: 20),

                      GestureDetector(
                        onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RegisterPage(),
                        ),
                        ),
                        child: Text("Don't have an account?|Register"),
                      ),
                       
                  ],
                ),
              ),
            ),
      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}