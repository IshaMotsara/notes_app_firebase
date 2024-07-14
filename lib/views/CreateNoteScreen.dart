import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  TextEditingController noteController=TextEditingController();
   User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:const  Text("Create Note"),
        centerTitle: true,
      ),
      body:Container(
        child: Column(
         children: <Widget>[
          TextField(
            controller:noteController,
            maxLines: null,
            decoration: const InputDecoration(
              hintText:"Note"
              
              ),
            
          ),
          ElevatedButton(
            onPressed: ()async{
              var note=noteController.text.trim();
              if(note!=""){
                try{
                 await FirebaseFirestore.instance.collection("notes")
                  .doc()
                  .set({
                  "createdAt":DateTime.now(),
                  "note":note,
                  "userId":userId?.uid,

                  });
                }
                catch(e){
                  print("Error $e");
                }

                }
              },
            
            child: const Text("Add Note"),),
          ],
          
        )
      )
    );     
  }
}