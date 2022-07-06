import 'package:bubble/bubble.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dialogflow_flutter/dialogflowFlutter.dart';
import 'package:dialogflow_flutter/googleAuth.dart';
import 'package:dialogflow_flutter/language.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/view/auth/to_image.dart';
import 'package:intl/intl.dart';
class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messageController=TextEditingController();
  List<Map<String, dynamic>> messages = [];
  var  _url='';
  void getData() async {
    User result = await FirebaseAuth.instance.currentUser!;
    var vari = await FirebaseFirestore.instance
        .collection('users')
        .doc(result.uid).get();
    setState(() {
      _url=vari.data()!['profileImage'];
    });
  }
  void response(query)async{
    AuthGoogle authGoogle=await AuthGoogle(
        fileJson: "assets/images/flutter-agent-iyto-014cf622f9fc.json"
    ).build();
    DialogFlow dialogFlow=DialogFlow(authGoogle: authGoogle,language: Language.english);
    AIResponse aiResponse=await dialogFlow.detectIntent(query);
    setState(() {
      messages.insert(0,{
        'data':0,
        'message':aiResponse.getListMessage()![0]['text']["text"][0].toString()
      });
    });
    print(aiResponse.getListMessage()![0]["text"]["text"][0].toString());
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("ChatBot",style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ToImage()));
        },),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 15,bottom: 10),
                child: Text("Today,${DateFormat("Hm").format(DateTime.now())}",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold),),
              ),
            ),
            Flexible(child: ListView.builder(reverse: true,itemCount: messages.length,itemBuilder: (context,index)=>
                chat(messages[index]['message'].toString(),messages[index]['data'])
            )
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 5,
              color: Colors.black,
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color.fromRGBO(220, 220, 220, 1),

                  ),
                  padding: EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      hintStyle: TextStyle(
                          color: Colors.grey
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,

                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.send,size: 30,),
                  onPressed: (){
                    if(messageController.text.isEmpty){
                      print("empty message");
                    }
                    else{
                      setState(() {
                        messages.insert(0, {'data':1,'message':messageController.text});
                      });
                      response(messageController.text);
                      messageController.clear();

                    }
                    FocusScopeNode currentFocus=FocusScope.of(context);
                    if(currentFocus.hasPrimaryFocus){
                      currentFocus.unfocus();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget chat(String message,int data){
    return Container(
      padding: EdgeInsets.only(left:20,right: 20),
      child:Row(
        mainAxisAlignment: data==1?MainAxisAlignment.end:MainAxisAlignment.start,
        children: [
          data==0?Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/360_F_322383277_xcXz1I9vOFtdk7plhsRQyjODj08iNSwB.jpg"),
            ),
          ):Container(),
          Padding(padding: EdgeInsets.all(10),child: Bubble(
            radius: Radius.circular(15),
            elevation: 0,
            color: Colors.black12,
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(child: Container(
                    constraints: BoxConstraints(maxWidth: 200),
                    child: Text(
                      message,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                    ),
                  ))
                ],
              ),
            ),
          ),),
          data==1?Container(
            height: 60,
            width: 60,
            child: CircleAvatar(
              backgroundImage: NetworkImage(_url),
            ),
          ):Container(),
        ],
      ) ,
    );
  }
}
