import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


void userRegister(){
  @required String name;
  @required String email;
  @required String password;
  @required String phone;
}
class AuthServices extends ChangeNotifier{
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  Future<User?> register(String email,String password)async{
    try{

      UserCredential authResult=await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user =authResult.user;
      print(user) ;
    }catch(e){
      print(e.toString());
      return null;
      notifyListeners();
    }
  }
  Future<User?> create(String email,String password,String name,String phonenumber)async{
    try{

      UserCredential authResult=await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      User? user =firebaseAuth.currentUser;
      print(user) ;
    }catch(e){
      print(e.toString());
      return null;
      notifyListeners();
    }
  }
   Future<void> logoutEmail()async{
    await FirebaseAuth.instance.signOut();
   }
}