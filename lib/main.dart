import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireBaseDemo',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  var userName="";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async{
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

      FirebaseUser user = await _auth.signInWithGoogle(idToken: gSA.idToken, accessToken: gSA.accessToken);
      
      print("Name: ${user.displayName}");
      return user;
  }

  void _signOut(){
    googleSignIn.signOut();
    print("user çıkış yaptı");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("FireBase Demo"),
      ),
      body: new Padding(padding: const EdgeInsets.all(20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          new RaisedButton(onPressed: ()=>_signIn().then((FirebaseUser user)=>userName=user.displayName+" "+user.email), child: new Text("Sign in"), color: Colors.green,),
          new Padding(padding: const EdgeInsets.all(10.0)),
          new RaisedButton(onPressed: _signOut, child: new Text("Sign out"), color: Colors.red,),
          new Text(userName),
        ],
      )
      ),
    );
  }

}
