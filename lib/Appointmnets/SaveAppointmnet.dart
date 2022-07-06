import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../view/auth/to_image.dart';

class SaveAppointment extends StatefulWidget {
  const SaveAppointment({Key? key}) : super(key: key);

  @override
  _SaveAppointmentState createState() => _SaveAppointmentState();
}

class _SaveAppointmentState extends State<SaveAppointment> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Appointments", style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => ToImage()));
        },),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("users")
              .doc(user.uid)
              .collection("Appointmnet")
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot>snapshot) {
            if (!snapshot.hasData) {
              return
                const Center(
                  child: Text("No Appointmnets"),
                );
            } else {
              return ListView.builder(itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    String name = snapshot.data!.docs[index]['name'];
                    String email = snapshot.data!.docs[index]['email'];
                    String appo = snapshot.data!.docs[index]['Appointment'];
                    String url = snapshot.data!.docs[index]['photoURL'];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        child: InkWell(
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
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(url),
                                    )
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${name}", style: TextStyle(
                                      fontWeight: FontWeight.bold)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${email}", style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${appo}", style: TextStyle(
                                      fontWeight: FontWeight.bold),),
                                ),
                              ],
                            ),
                          ),
                          onTap: (){
                            showDialog(context: context, builder: (_)=>AlertDialog(title: Text("Cancel Appointment ?"),actions: [
                              FlatButton(onPressed: ()async{
                                deleteDoctor(snapshot.data!.docs[index].id);
                              }, child:Text("Ok"))
                            ],
                            )
                            );
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
  void deleteDoctor(id){
    FirebaseFirestore.instance.collection('users').doc(user.uid).collection('Appointmnet').doc(id).delete();
  }
}
