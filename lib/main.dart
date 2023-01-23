import 'package:flutter/material.dart';
import 'pages/signingup.dart';
import 'pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const InitialPage(),
    );
  }
}

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final _formKey = GlobalKey<FormState>();
  List<String> list = <String>['Member', 'Teacher', 'Board', 'Admin'];
  String? chosen = 'Member';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.9;
    var height = MediaQuery.of(context).size.height * 0.07;
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
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Enter School Email',
                          hintText: 'Enter your email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: SizedBox(
                          height: height * 1.2,
                          width: width,
                          child: TextFormField(
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
                              }
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) => Home()));
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
