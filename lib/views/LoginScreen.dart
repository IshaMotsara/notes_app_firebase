import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/views/forgotpasswordscreen.dart';
import 'package:notes_app/views/homescreen.dart';
import 'package:notes_app/views/signUpScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;

  // Add this state variable to track the password visibility
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 20,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                alignment: Alignment.center,
                child: Lottie.asset("assets/Animation - 1720082394279.json"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: loginEmailController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: loginPasswordController,
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                    child: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  hintText: "Password",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  var loginEmail = loginEmailController.text.trim();
                  var loginPassword = loginPasswordController.text.trim();
                  try {
                    final UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: loginEmail, password: loginPassword);
                    final User? firebaseUser = userCredential.user;
                    if (firebaseUser != null) {
                      Get.to(() => const HomeScreen());
                    } else {
                      print("Have to write something");
                    }
                  } on FirebaseAuthException catch (e) {
                    print("Error $e");
                  }
                },
                child: const Text("Login"),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ForgotPasswordScreen());
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Forgot Password"),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(() => const SignUpScreen());
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Don't have an account? Sign up"),
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
