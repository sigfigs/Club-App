import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'signup.dart';
import 'home.dart';
import '../clubs_db.dart';
import '../user.dart';

Map<String, dynamic> userData = {};
bool isLoggedIn = false;
FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
var firebaseUser = FirebaseAuth.instance.currentUser!;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  Future<void> getUserData() async {
    // var firebaseUser = await FirebaseAuth.instance.currentUser!;
    String docID = "kvutT3X9zqR2qX5P2W14";
    DocumentSnapshot document = await usersCollection.doc(docID).get();
    userData = document.data() as Map<String, dynamic>;
    print(userData);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Signed in");
      getUserData();

      isLoggedIn = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  State<SignInPage> createState() => _SignInPageState();
}

var db;

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    db = Dbhelper();
    db.initDb();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.9;
    var height = MediaQuery.of(context).size.height * 0.07;
    TextEditingController t1 = TextEditingController();
    TextEditingController t2 = TextEditingController();
    return MaterialApp(
      title: 'Login and Sign Up',
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
              child: Container(
            width: 500,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset("assets/bxsci-clubs-logo.png",
                          width: 120)),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: const Text('Sign in to SciClubs',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF097969)),
                          textAlign: TextAlign.center)),
                  Container(
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Color(0xFFF6F8FA),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        SizedBox(
                            height: height * 1.2,
                            child: TextFormField(
                                onTap: () {},
                                controller: t1,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  labelText: 'OSIS or Email',
                                  // hintText: 'Enter your OSIS or email',
                                ),
                                validator: (value) {})),
                        Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SizedBox(
                                height: height * 1.2,
                                child: TextFormField(
                                  controller: t2,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    labelText: 'Password',
                                  ),
                                  obscureText: true,
                                  validator: (value) {},
                                ))),
                        Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SizedBox(
                                width: 500,
                                height: height,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: const Color(0xFF097969)),
                                  onPressed: () async {
                                    widget.signInWithEmailAndPassword(
                                        t1.text, t2.text);
                                    if (isLoggedIn) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()));
                                    }
                                  },
                                  child: const Text('Sign in',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ))),
                        Divider(color: Colors.grey[100]),
                        Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: SizedBox(
                                width: 500,
                                height: height,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      backgroundColor: Colors.white),
                                  onPressed: () async {},
                                  child: const Text('Continue with Google',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black)),
                                )))
                      ])),
                  SizedBox(height: height / 4, width: width),
                  Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      width: 500,
                      height: height,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpPage(),
                            ),
                          );
                        },
                        child: const Text('New to SciClubs? Create an account.',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black)),
                      )),
                ]),
          )),
        ),
      ),
    );
  }
}

Userx ac = Userx(["0", "1", "2", "3", "4", "5"], "userEmail", "password",
    "name", "role", 2023, 222445629, "info");
