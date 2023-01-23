import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';
import '../clubs_db_3.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                            width: 150,
                            child: Text('BxSci Clubs',
                                style: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF097969))))
                      ]),
                  const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('Catch up with your favorite club!',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF097969)),
                          textAlign: TextAlign.center)),
                  SizedBox(
                      height: height * 1.2,
                      width: width,
                      child: TextFormField(
                          controller: t1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Enter School OSIS or EMAIL',
                            hintText: 'Enter your OSIS',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            var osis = [];
                            var email = [];
                            for (int i = 0; i < userdata.length; i++) {
                              osis.add(userdata[i][1]);
                              email.add(userdata[i][2]);
                              print(userdata[i][1]);
                            }
                            if (!osis.contains(t1) || !email.contains(t1)) {
                              return 'Email or OSIS does not exist';
                            }
                            return null;
                          })),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: SizedBox(
                          height: height * 1.2,
                          width: width,
                          child: TextFormField(
                            controller: t2,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter your password',
                            ),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              }
                              Map osis = {};
                              Map email = {};
                              for (int i = 0; i < userdata.length; i++) {
                                osis[userdata[i][1]] = userdata[i][3];
                                email[userdata[i][2]] = userdata[i][3];
                              }
                              if (osis[t1.text] != t2.text ||
                                  email[t1.text] != t2.text) {
                                return 'Incorrect Password';
                              }
                              return null;
                            },
                          ))),
                  SizedBox(height: height / 4, width: width),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: SizedBox(
                          width: width,
                          height: height,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: const Color(0xFF097969)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _formKey.currentState!.reset();

                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) => Home()));
                              }
                            },
                            child: const Text('LOG IN',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ))),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: SizedBox(
                          width: width,
                          height: height,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: const Color(0xFF097969)),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              );
                            },
                            child: const Text('SIGN UP',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Forgot Your Email?',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[400]))),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Forgot Your Password?',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[400]))),
                ]),
              )),
            ),
          ),
          floatingActionButton: const Icon(Icons.phonelink_ring_rounded),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        ));
  }
}
