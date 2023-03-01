import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'signin.dart';
import 'home.dart';

List userInfo = [];
bool hasSignedUp = false;

CollectionReference users = FirebaseFirestore.instance.collection('users');

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});


  Future<void> addUser(String full_name, String osis, String official_class,
      String graduation_year, String bxscience_email, String password) {
    // Call the user's CollectionReference to add a new user

    return users
        .add({
          'full_name': full_name, // John Doe
          'osis': osis,
          'official_class': official_class,
          'graduation_year': graduation_year,
          'bxscience_email': bxscience_email,
          'password': password,
          'clubs': {},
          'user_type': "Member"
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Signed up");
      hasSignedUp = true;
    } on FirebaseAuthException catch (e) {}
  }

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
          body: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      width: 500,
                      padding: EdgeInsets.all(20),
                      child: Column(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset("assets/bxsci-clubs-logo.png",
                                width: 120)),
                        const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('Sign up for SciClubs',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF097969)),
                                textAlign: TextAlign.center)),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(children: [
                              buildField("Full Name"),
                              buildField("OSIS"),
                              buildField("Official Class"),
                              buildField("Graduation Year"),
                              buildField("Bronx Science Email"),
                              buildField("Password"),
                              buildField("Confirm Password"),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: SizedBox(
                                      width: 500,
                                      height: height,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            backgroundColor:
                                                const Color(0xFF097969)),
                                        onPressed: () async {
                                          userInfo.clear();
                                          if (_formKey.currentState!
                                              .validate()) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home(),
                                              ),
                                            );
                                            widget
                                                .createUserWithEmailAndPassword(
                                                    userInfo[4], userInfo[5]);
                                            widget.addUser(
                                                userInfo[0],
                                                userInfo[1],
                                                userInfo[2],
                                                userInfo[3],
                                                userInfo[4],
                                                userInfo[5]);
                                            if (hasSignedUp) {
                                              // ignore: use_build_context_synchronously
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Home()),
                                              );
                                            }
                                          }
                                        },
                                        child: const Text('Sign Up',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                      )))
                            ])),
                        SizedBox(height: height / 4, width: width),
                        Container(
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
                                    builder: (context) => const SignInPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                  'Already have an account? Login here.',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            )),
                      ]),
                    ),
                  ),
                ),
              )),
        ));
  }
}

Widget buildField(String info) {
  TextEditingController t1 = TextEditingController();

  return Container(
    margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
    height: 25,
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
    ),
    child: TextFormField(
      controller: t1,
      decoration: InputDecoration.collapsed(
        hintText: '$info',
        hintStyle: const TextStyle(fontSize: 16.0),
      ),
      validator: (value) {
        userInfo.add(t1.text);
        print(userInfo);
        print(t1.text);
        if (value!.isEmpty) {
          return 'Please enter your ${info.toLowerCase()}';
        }
        return null;
      },
    ),
  );
}
