import 'package:flutter/material.dart';
import 'signup.dart';
import 'home.dart';
import '../clubs_db_3.dart';
import 'package:club_app_5/user.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

late User ac;
var db;

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();
    db = Dbhelper();
    db.initDb();
  }

  var person = 0;

  void login(
      var name, var email, var osis, var password, var usertype, var clubs) {
    ac = User(clubs.split(' '), email, password, name, usertype, 2023,
        int.parse(osis), 'My name is Ben and I like girls.');
  }

  int addall = 0;
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
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset("assets/bxsci-clubs-logo.png",
                          width: 120)),
                  const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('Sign in to BxSci Clubs',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF097969)),
                          textAlign: TextAlign.center)),
                  SizedBox(
                      height: height * 1.2,
                      width: width * 0.4,
                      child: TextFormField(
                          onTap: () {
                            if (addall == 0) {
                              db.getData();
                              addall += 1;
                            }
                          },
                          controller: t1,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: 'Enter osis or email',
                            // hintText: 'Enter your OSIS or email',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter osis or email';
                            }
                            for (int i = 0; i < userdata.length; i++) {
                              if (userdata[i][1] == t1.text ||
                                  userdata[i][2] == t1.text) {
                                person = i;
                                return null;
                              }
                            }
                            return 'Email or OSIS does not exist';
                          })),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: SizedBox(
                          height: height * 1.2,
                          width: width * 0.4,
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
                              // print(osis);
                              // print(email);
                              if (osis[t1.text] == t2.text) {
                                return null;
                              } else if (email[t1.text] == t2.text) {
                                return null;
                              }
                              return 'Incorrect Password';
                            },
                          ))),
                  SizedBox(height: height / 4, width: width),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: SizedBox(
                          width: width * 0.4,
                          height: height,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                backgroundColor: const Color(0xFF097969)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                login(
                                    'Benjamin Chong',
                                    userdata[person][2],
                                    userdata[person][1],
                                    userdata[person][3],
                                    userdata[person][4],
                                    userdata[person][5]);
                                _formKey.currentState!.reset();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()));
                              }
                            },
                            child: const Text('Sign in',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ))),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: SizedBox(
                          width: width * 0.2,
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
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Forgot Your Email?',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[300]))),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text('Forgot Your Password?',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[300]))),
                ]),
              )),
            ),
          ),
          floatingActionButton: const Icon(Icons.phonelink_ring_rounded),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        ));
  }
}
