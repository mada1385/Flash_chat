import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class User {
  
  
  Future register (String email , String password , String route )
  async{
  final _auth = FirebaseAuth.instance;
  try
{
    final user = await _auth.createUserWithEmailAndPassword(email: email,password: password) ;
    if (user!=null)
    {
     return user ;
    }
} 
catch(e){
  return e;
}
 }
  

}