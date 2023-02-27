

import 'package:firebase_test/reusables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'get_data.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions( apiKey: "AIzaSyCQwl8vIrYbyL-HaRxDun2u-WNjg6Z4K6M",
      projectId: "fir-test-92243",
      messagingSenderId: "413461745003",
      appId: "1:413461745003:web:05dc9e206b877fc7d6102e",
   ));

  runApp(FirebaseApp());
}

class FirebaseApp extends StatefulWidget {
  TextEditingController nameController= TextEditingController();


  @override
  State<FirebaseApp> createState() => _FirebaseAppState();
}

class _FirebaseAppState extends State<FirebaseApp> {

  TextEditingController nameController= TextEditingController();
  var name;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: Builder(
         builder: (context) {
           return Scaffold(
            appBar: AppBar(
              title: Text("Firebase app"),
            ),
            body: Column(
              children: [
                TextField(
                  controller: nameController,
                  onChanged: (value) => name,
                  decoration: InputDecoration(
                    label: Text("name"),
                    hintText: 'enter your name here!'

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ElevatedButton(onPressed: (){
                    setState(() {
                      name=nameController.text;
                    });
                    FirebaseFirestore.instance.collection("users").doc(name).set({'Name':'$name'});},
                    child: Text("Add data"),),
                ),
                ElevatedButton(onPressed:(){
                  Navigator.push((context), MaterialPageRoute(builder: (context)=> GetData()));
                } , child: Text("Go to get data"))

              ],
            ),
      );
         }
       ),
    );
  }
}
