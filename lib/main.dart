import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:notes_app/views/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/views/homescreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:const  FirebaseOptions(
      apiKey: "AIzaSyDvmfNm63pRRGsd2LEZ-lR3wKOhRQbHirA",
      appId: "1:55809669334",
        messagingSenderId: "55809669334",
        projectId:  "noteapp-5ef11"),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key}); 
   

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User?user;
  @override
  void initState(){
    super.initState();
    user=FirebaseAuth.instance.currentUser;
    print(user?.uid.toString());
    
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user!=null?const HomeScreen():const LoginScreen(),);
      }
      }