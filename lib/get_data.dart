import 'package:firebase_test/reusables.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetData extends StatefulWidget {
  @override
  State<GetData> createState() => _GetDataState();
}

class _GetDataState extends State<GetData> {
 late CollectionReference _collectionRef;
 @override



  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Get data pagge"),
        ),
         body:StreamBuilder<QuerySnapshot>(
           stream: FirebaseFirestore.instance.collection('users').snapshots(),
           builder: (context, snapshot) {
             if (snapshot.hasData) {
               return ListView.builder(
                   itemCount: snapshot.data!.docs.length,
                   itemBuilder: (context, index) {
                     DocumentSnapshot doc = snapshot.data!.docs[index];
                     return Center(
                       child:  ListTile(
                         trailing: IconButton(
                           onPressed: (){
                             deleteUser(snapshot.data?.docs[index].id);
                           },
                           icon: Icon(Icons.delete),
                         ),
                         leading: IconButton(
                           onPressed: (){
                             updateUser(snapshot.data?.docs[index].id);
                           },
                           icon: Icon(Icons.edit),
                         ),
                         title: Text(doc['Name'],
                           
                         ),
                       ),
                     );
                   });
             } else {
               return Text("No data");
             }
           },
         )
      // StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //           itemCount: snapshot.data!.docs.length,
        //           itemBuilder: (context, index) {
        //             DocumentSnapshot doc = snapshot.data!.docs[index];
        //             return ListTile(title:  Text(doc['Name']),leading: IconButton(
        //               icon: Icon(Icons.delete),
        //               onPressed: (){
        //               deleteUser(snapshot.data?.docs[index].id);
        //               },
        //             ),
        //             trailing:  IconButton(
        //               icon: Icon(Icons.edit),
        //               onPressed: (){
        //
        //               },
        //             ),
        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),);
        //           });
        //     } else {
        //       return Text("No data");
        //     }
        //   },
        // )


        // FutureBuilder<QuerySnapshot>(
        //   future: _collectionRef.get(),
        //   builder: (context, snapshot) {
        //     switch (snapshot.connectionState) {
        //       case ConnectionState.waiting:
        //         return Text('Loading....');
        //       default:
        //         if (snapshot.hasError) {
        //           return Text('Error: ${snapshot.error}');
        //         } else {
        //           QuerySnapshot? querySnapshot = snapshot.data;
        //
        //           return ListView.builder(
        //             itemCount: querySnapshot?.docs.length ?? 0,
        //             itemBuilder: (BuildContext context, int index) {
        //               var data = querySnapshot?.docs[index].data();
        //               print("data = $data");
        //               return Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Container(
        //                     decoration: BoxDecoration(
        //                       color: Colors.yellow,
        //
        //                     ),
        //                     child: Text("$data")),
        //               );
        //             },
        //           );
        //         }
        //     }
        //   },
        // ),

    );
  }
}

void deleteUser(id) {
  FirebaseFirestore.instance.collection('users').doc(id).delete();
}
Future updateUser(id) {
  CollectionReference _ref =
  FirebaseFirestore.instance.collection('users');

  var context;
  return showDialog(context: (context), builder: (BuildContext context){
    var kNameUpdated;
    var kAgeUpdated;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update detais"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            kTextFormField(
                lable: 'name',
                kController: kNameUpdated,
                obscure: false,
                icon: const Icon(Icons.person),

                validator: (val) {
                  if (val== null) {
                    print('This field can not be empty ');
                  }
                }),
            const SizedBox(height: 30),
            kTextFormField(
              lable: "age",
              kController: kAgeUpdated,
              obscure: false,
              icon: const Icon(Icons.escalator_warning_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'age Required';
                }
                return null;
              },
            ),
            SizedBox(height: 30,),

            Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {


                    _ref.doc(id).update({
                      'name':kNameUpdated,
                      'age':kAgeUpdated ,
                    });

                    kAgeUpdated.clear();
                    kNameUpdated.clear();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,

                        fontWeight: FontWeight.bold),
                  ),
                )),
          ],
        ),
      ),
    );
  });
}


