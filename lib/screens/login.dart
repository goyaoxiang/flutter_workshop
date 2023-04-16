import 'package:flutter/material.dart';
import 'package:google_signin/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class FirebaseServices {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          return user;
        }
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  googleSignOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.teal,
          Colors.teal.shade300,
          Colors.teal.shade100,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: ElevatedButton(
              onPressed: () async {
                await FirebaseServices().signInWithGoogle();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.black26;
                  }
                  return Colors.white;
                }),
              ), // ButtonStyle
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage('assets/google.png'),
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Login with Gmail",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ), // Text
                  ],
                ), // Row
              ), // Padding
            ), // ElevatedButton
          ), // Container
        ), // Center
      ), // Container
    ); // Scaffold
  }
}