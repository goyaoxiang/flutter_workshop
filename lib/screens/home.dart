import 'package:flutter/material.dart';
import 'package:google_signin/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: <Widget>[
            Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
            SizedBox(height:20,),
            Text("${FirebaseAuth.instance.currentUser!.displayName}"),
            Text("${FirebaseAuth.instance.currentUser!.email}"),
            SizedBox(height:20,),
            ElevatedButton(
              child: Text("Logout"),
              onPressed:()async{
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen())
              );
              },
            ), // ElevatedButton
          ] // <Widget>[]
        ), // Column
      ), // Center
    ); // Scaffold
  }
}