import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/views/Services/signUpServices.dart';
import 'package:notes_app/views/LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
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
        title: const Text("SignUp"),
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
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.verified_user),
                  hintText: "Username",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: userPhoneController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Phone",
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: userEmailController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: userPasswordController,
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
                  var userName = userNameController.text.trim();
                  var userPhone = userPhoneController.text.trim();
                  var userEmail = userEmailController.text.trim();
                  var userPassword = userPasswordController.text.trim();
                  if (userPhone.length > 10) {
                    Get.snackbar(
                      "Invalid Phone Number",
                      "Phone number cannot exceed 10 digits",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword)
                      .then((value) => {
                            print("user created"),
                            signUpUser(
                              userName,
                              userPhone,
                              userEmail,
                              userPassword,
                            )
                          });
                },
                child: const Text("SignUp"),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Get.to(() => const LoginScreen());
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Already have an account? Log in"),
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
