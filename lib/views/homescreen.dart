import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:notes_app/views/CreateNoteScreen.dart';
import 'package:notes_app/views/LoginScreen.dart';
import 'package:notes_app/views/editNoteScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:const BackButton(),
        centerTitle: true,
        backgroundColor: Colors.blue,
        title:const Text("Home Screen"),
        actions: [
          GestureDetector(
            onTap:(){
              FirebaseAuth.instance.signOut();
              Get.off(()=>const LoginScreen());
            },
         child: const Icon(Icons.logout),),
        ],
      ),
      body:Container(
        child:StreamBuilder(stream: FirebaseFirestore.instance.collection("notes")
        .where("userId" ,isEqualTo:userId?.uid).snapshots(),
         builder: (context,AsyncSnapshot<QuerySnapshot>snapshot){
          
         if(snapshot.hasError){
          return const Text("Something Went Wrong");
         }
         if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child:CupertinoActivityIndicator(),
            );
            }
            if(snapshot.data!.docs.isEmpty){
              return const Text("No Data Found!");
            }
            if(snapshot!=null && snapshot.data!=null){
              return ListView.builder(
                itemCount:snapshot.data!.docs.length,
                itemBuilder:(context,index){
                   var note = snapshot.data!.docs[index];
                    var noteText = note['note'];
                  var noteId = note.id;
                  var docId=snapshot.data!.docs[index].id;
                         return Card(
                          child:ListTile(title:  Text(noteText),  
                          subtitle:Text(note.id),
                          trailing: Row(
                            mainAxisSize:MainAxisSize.min,
                            children:[
                              GestureDetector(
                                onTap: (){
                                  Get.to(()=>const EditScreen(),arguments: {
                                    'note':note,
                                    'docId':docId,
                                  });
                                },
                              child:const Icon(Icons.edit),
                              ),
                              GestureDetector(
                                onTap:(){
                                  FirebaseFirestore.instance
                                  .collection("notes")
                                  .doc(docId)
                                  .delete();
                                },
                             child:const Icon(Icons.delete),)
                            ]
                          )
                          ),
                         );
                },
                );

            }
            return Container();
         }


          ),),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=>const NoteScreen());
        },
        child:const Icon(Icons.add)
        
        ),
      );
  }
}