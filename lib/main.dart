import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/view/auth/OnBoarding.dart';
import 'package:flutter_app/view/auth/home_page.dart';
import 'package:flutter_app/view/auth/google_sign_in.dart';
import 'package:flutter_app/widgets/sign_in_email.dart';
import 'package:provider/provider.dart';
Future<void> main () async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return MultiProvider(providers:[
     ChangeNotifierProvider(create: (context)=>GoogleSignInProvider()),ChangeNotifierProvider(create: (context)=>AuthServices())],
     child: MaterialApp(
       theme:ThemeData(
         inputDecorationTheme: InputDecorationTheme(
           enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(30)),borderSide: BorderSide(color: Colors.black54))
         )
       ),
       debugShowCheckedModeBanner: false,
       home: Scaffold(
         body:HomePage(
         ),
       ),
     ),
   );
  }
}
  /**
      Container(
      child: Padding(
      padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Text("Registration",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
      decoration: InputDecoration(
      labelText: "Name", prefixIcon: Icon(Icons.account_circle)),
      keyboardType: TextInputType.name,
      ),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
      decoration: InputDecoration(
      labelText: "Phone number",
      prefixIcon: Icon(Icons.add_ic_call_rounded)),
      keyboardType: TextInputType.number,
      ),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
      decoration: InputDecoration(
      labelText: "Email", prefixIcon: Icon(Icons.email)),
      keyboardType: TextInputType.emailAddress,
      ),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
      decoration: InputDecoration(
      labelText: "New Password",
      prefixIcon: Icon(Icons.vpn_key)
      )),
      ),
      Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
      height: 60,
      width: double.infinity,
      child: RaisedButton(onPressed: (){
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Text("Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
      ),
      ),
      ),
      ],
      ),
      ),
      ),
      **/