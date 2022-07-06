import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Doctor/data_time_picker_widget2.dart';
import 'package:flutter_app/view/auth/to_image.dart';
class DoctorList extends StatefulWidget {
  const DoctorList({Key? key}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Doctor",style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ToImage()));
        },),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Doctor").snapshots(),
          builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot>snapshot){
            if(!snapshot.hasData){
              return
                const Center(
                  child: Text("No image Uploaded"),
                );
            }else{
              return ListView.builder(itemCount: snapshot.data!.docs.length,itemBuilder: (BuildContext context,int index){
                String name=snapshot.data!.docs[index]['name'];
                String email=snapshot.data!.docs[index]['email'];
                String phone=snapshot.data!.docs[index]['phone'];
                String url=snapshot.data!.docs[index]['photoURL'];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    child: InkWell(
                      child: Container(
                        height: 100,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(url),
                              )
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Text("${name}",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${phone}",style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DateTimePickerWidget2()));
                      },
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
