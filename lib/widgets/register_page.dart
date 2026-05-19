import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:my_project/widgets/input_field.dart';
import 'package:my_project/login_page.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();
  final TextEditingController _cPasswordController =
      TextEditingController();

  bool _isLoading = false;

  final _supabase = Supabase.instance.client;

  void register() async {
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _isLoading = true;
    });

    try {
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = authResponse.user;

      if (user != null) {
        await _supabase.from('profiles').insert({
          'id': user.id,
          'name': name,
          'email': email,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registered Successfully"),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        );
      }
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
    } catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(e.toString()),
    ),
      );
    }

    setState(() {
      _isLoading = false;
    });

    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _cPasswordController.clear();
  }

  

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.cyanAccent,
      title: Text("Register"),
    ),

    body: SingleChildScrollView(
      child: Center(
        child: SizedBox(
    width: 420,
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Card(
            color: Colors.white,
            elevation: 5,

            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Form(
                key: _formKey,

                child: Column(

                  children: [

                    /// HEADER
                    Container(
                      width: 300,
                      padding: EdgeInsets.all(20),

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
                              color: Colors.cyanAccent,
                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Icon(
                              Icons.person_outline,
                              color: Colors.blue,
                            ),
                          ),

                          SizedBox(height: 20),

                          Text("Create Account",
                          style: TextStyle(fontSize:25,fontWeight:  FontWeight.bold),
                          ),
                          Text("Sign up to get started",
                          style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// NAME
                    InputField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      hintText: "Enter Name",
                      labelText: "Name",
                      prefixIcon: const Icon(Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter name";
                        }
                        if (!RegExp(r'^[a-zA-Z .]+$').hasMatch(value)) {
                          return "Please give a valid name";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    /// EMAIL
                    InputField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Enter Email",
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    /// PASSWORD
                    InputField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Enter password",
                      labelText: "Password",
                      obscureText: true,
                      prefixIcon: Icon(Icons.lock),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter password";
                        }

                        if (!RegExp(
                          r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,}$',
                        ).hasMatch(value)) {
                          return "Enter a strong password!!";
                        }

                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    /// CONFIRM PASSWORD
                    InputField(
                      controller: _cPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Confirm Password",
                      labelText: "Confirm Password",
                      obscureText: true,
                      prefixIcon: Icon(Icons.lock),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Confirm Password";
                        }

                        if (value != _passwordController.text) {
                          return "Passwords do not match";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    /// BUTTON
                    ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                register();
                              }
                            },
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              "Register",
                              style: TextStyle(fontSize: 18),
                            ),
                    ),

                    SizedBox(height: 20),

                    /// LOGIN NAV
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text("Already have an account? | Login"),
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
  );
}
}