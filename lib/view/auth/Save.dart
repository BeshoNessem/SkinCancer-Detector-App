import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/to_image.dart';
class Save extends StatefulWidget {
  const Save({Key? key}) : super(key: key);

  @override
  _SaveState createState() => _SaveState();
}

class _SaveState extends State<Save> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:Text("History",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>ToImage()));
          },
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users").doc(user.uid).collection("images").snapshots(),
          builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return
                const Center(
                  child: Text("No image Uploaded"),
                );
            }else{
              return ListView.builder(itemCount: snapshot.data!.docs.length,itemBuilder: (BuildContext context,int index){
                String url=snapshot.data!.docs[index]['imageUrl'];
                String post=snapshot.data!.docs[index]['Time'];
                String model=snapshot.data!.docs[index]['Label'];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 170,
                    width: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50),
                      ),
                    child: Column(
                      children: [

                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Image.network(url,height: 90,width: 50),
                           ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("${post}",style: TextStyle(fontWeight: FontWeight.bold),),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("${model}",style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                );
              });
            }
          },
        ),
      ),
    );
  }
}
