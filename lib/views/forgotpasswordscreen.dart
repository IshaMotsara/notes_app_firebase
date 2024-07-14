import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/views/LoginScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgotPasswordScreen> {
  TextEditingController forgotPasswordController = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ForgotPassword"),
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
                  controller: forgotPasswordController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  prefixIcon:Icon(Icons.email),
                  hintText: "Email",
                ),
              ), 
              const SizedBox(
                height:20,
              ),
              
              
              ElevatedButton(
                onPressed: ()async {
                 var forgotEmail=forgotPasswordController.text.trim();
                  try{
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmail)
                    .then((value){
                      print("Email sent!");
                      Get.off(()=>const LoginScreen());
                    });


                  }on FirebaseAuthException catch(e){
                    print("Error  $e");
                  }
                },
                child: const Text("Forgot Password"),
              ),
             
          
            ],
          ),
        ),
      ),
    );
  }
}
