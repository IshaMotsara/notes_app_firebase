import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/views/homescreen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Check if arguments are passed and set the text
    final note = Get.arguments['note'];
    if (note != null) {
      noteController.text = note['note'].toString();
    } else {
      // Handle the case where no arguments are passed
      noteController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Edit Notes"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: noteController,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("notes")
                    .doc(Get.arguments['docId'].toString())
                    .update({'note': noteController.text.trim()})
                    .then((_) {
                  Get.offAll(() =>const HomeScreen());
                  print("Data Updated");
                });
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
