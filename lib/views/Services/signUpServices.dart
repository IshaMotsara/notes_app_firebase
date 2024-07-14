import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/views/LoginScreen.dart';



signUpUser(
  String userName,
  String userPhone,
String userEmail,
  String userPassword,
)async{
  User?userid = FirebaseAuth.instance.currentUser;
  try{
  FirebaseFirestore.instance
                     .collection("users").doc(userid!.uid).set({
                        'userName':userName,
                        'userPhone':userPhone, 
                        'userEmail':userEmail,
                        'createdAt':DateTime.now(),
                        'userId':userid!.uid,
                      });
                       await {FirebaseAuth.instance.signOut(),
                      Get.to(()=>const LoginScreen()),};
                      
  } on FirebaseAuthException catch (e){
    print("Error $e");
  }
}

