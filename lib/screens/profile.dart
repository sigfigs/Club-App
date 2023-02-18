import 'package:flutter/material.dart';
import 'package:club_app_5/user.dart';
import 'signin.dart';
import 'package:club_app_5/clubs_db.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var admin = ac.role == 'Admin';
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          foregroundColor: Colors.black,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: const Text("Profile", style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Container(
            margin: EdgeInsets.fromLTRB(25, 75, 25, 25),
            child: actual(width, height, ac)),
        floatingActionButton: admin == true
            ? FloatingActionButton(
                elevation: 3,
                child: const Icon(Icons.list),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => people()));
                })
            : null);
  }

  Widget people() {
    return Scaffold(
        appBar: AppBar(title: Text('All User Information')),
        body: ListView.builder(
          itemCount: userdata.length,
          itemBuilder: (context, index) {
            return ListTile(
                trailing: const Icon(Icons.delete),
                title: Text(userdata[index].toString(),
                    style: const TextStyle(
                        color: Color(0xFF097969), fontSize: 15)));
          },
        ));
  }

  Widget actual(var height, var width, User ac) {
    return SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
              radius: 50,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset("assets/funnymonkeylips.png")))),
      GestureDetector(
          onTap: (() => _displayNameDialog(context, ac)),
          child: Text(ac.name,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500))),
      GestureDetector(
          onTap: (() => _displayEmailDialog(context, ac)),
          child: Text(ac.email,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500))),
      GestureDetector(
          onTap: (() => _displayOsisDialog(context, ac)),
          child: Text(ac.osis.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500))),
      buildProfile(ac),
      Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
            width: 500,
            height: 50,
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
              child: const Text('Sign Out',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            )),
      )
    ]));
  }

  Future<Future> _displayNameDialog(BuildContext context, User c) async {
    TextEditingController nameController1 = TextEditingController();
    TextEditingController nameController2 = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            insetPadding: const EdgeInsets.all(20),
            backgroundColor: Colors.white,
            title: const Text(
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                'Change Your Information'),
            content: SizedBox(
                width: width / 2,
                height: height / 4,
                child: Form(
                    key: formKey,
                    child: Column(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: TextFormField(
                            controller: nameController1,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Your Name',
                                labelStyle: TextStyle(color: Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the new name';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: TextFormField(
                            controller: nameController2,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Your Name',
                                labelStyle: TextStyle(color: Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please confirm new name';
                              }
                              if (nameController2.text !=
                                  nameController1.text) {
                                return 'New name is not the same';
                              }
                              return null;
                            },
                          )),
                    ]))),
            actions: <Widget>[
              // add button
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Text('Confirm',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400])),
                onPressed: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      c.name = nameController2.text;
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
              // Cancel button
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400])),
                onPressed: () {
                  Navigator.of(context).pop();
                  nameController1.clear();
                },
              )
            ],
          );
        });
  }

  Future<Future> _displayOsisDialog(BuildContext context, User c) async {
    TextEditingController nameController1 = TextEditingController();
    TextEditingController nameController2 = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            insetPadding: const EdgeInsets.all(20),
            backgroundColor: Colors.white,
            title: const Text(
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                'Change Your Information'),
            content: SizedBox(
                width: width / 2,
                height: height / 4,
                child: Form(
                    key: formKey,
                    child: Column(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: TextFormField(
                            controller: nameController1,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Your OSIS',
                                labelStyle: TextStyle(color: Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the new OSIS';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: TextFormField(
                            controller: nameController2,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Your OSIS',
                                labelStyle: TextStyle(color: Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please confirm new OSIS';
                              }
                              if (nameController2.text !=
                                  nameController1.text) {
                                return 'New OSIS is not the same';
                              }
                              return null;
                            },
                          )),
                    ]))),
            actions: <Widget>[
              // add button
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Text('Confirm',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400])),
                onPressed: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      c.osis = nameController2.text as int;
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
              // Cancel button
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400])),
                onPressed: () {
                  Navigator.of(context).pop();
                  nameController1.clear();
                },
              )
            ],
          );
        });
  }

  Future<Future> _displayEmailDialog(BuildContext context, User c) async {
    TextEditingController nameController1 = TextEditingController();
    TextEditingController nameController2 = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            insetPadding: const EdgeInsets.all(20),
            backgroundColor: Colors.white,
            title: const Text(
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                'Change Your Information'),
            content: SizedBox(
                width: width / 2,
                height: height / 4,
                child: Form(
                    key: formKey,
                    child: Column(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: TextFormField(
                            controller: nameController1,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Your Email',
                                labelStyle: TextStyle(color: Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the new email';
                              }
                              return null;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: TextFormField(
                            controller: nameController2,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Your Email',
                                labelStyle: TextStyle(color: Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please confirm new Email';
                              }
                              if (nameController2.text !=
                                  nameController1.text) {
                                return 'New name is not the Email';
                              }
                              return null;
                            },
                          )),
                    ]))),
            actions: <Widget>[
              // add button
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Text('Confirm',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400])),
                onPressed: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      c.email = nameController2.text;
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
              // Cancel button
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400])),
                onPressed: () {
                  Navigator.of(context).pop();
                  nameController1.clear();
                },
              )
            ],
          );
        });
  }

  Future<Future> _displayAboutDialog(BuildContext context, User c) async {
    TextEditingController nameController1 = TextEditingController();
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            insetPadding: const EdgeInsets.all(20),
            backgroundColor: Colors.white,
            title: const Text(
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
                'Change Your Information'),
            content: SizedBox(
                width: width / 2,
                height: height / 4,
                child: Form(
                    key: formKey,
                    child: Column(children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5, top: 10),
                          child: TextFormField(
                            maxLines: 5,
                            controller: nameController1,
                            decoration: const InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                labelText: 'Confirm Your Details',
                                labelStyle: TextStyle(color: Colors.black)),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter the new Details';
                              }
                              return null;
                            },
                          )),
                    ]))),
            actions: <Widget>[
              // add button
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Text('Confirm',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400])),
                onPressed: () {
                  setState(() {
                    if (formKey.currentState!.validate()) {
                      c.info = nameController1.text;
                      Navigator.of(context).pop();
                    }
                  });
                },
              ),
              // Cancel button
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                child: Text('Cancel',
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400])),
                onPressed: () {
                  Navigator.of(context).pop();
                  nameController1.clear();
                },
              )
            ],
          );
        });
  }

  Widget buildProfile(User user) {
    return SingleChildScrollView(
        child: Column(
      children: [
        const Divider(),
        ListTile(
          tileColor: Colors.grey[50],
          contentPadding: const EdgeInsets.all(5),
          leading: const Icon(Icons.school_rounded),
          title: const Text('Gradudation Year',
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(user.gradyear.toString()),
        ),
        const Divider(),
        GestureDetector(
            onTap: (() => _displayAboutDialog(context, ac)),
            child: ListTile(
              trailing: const Icon(Icons.edit),
              tileColor: Colors.grey[50],
              contentPadding: const EdgeInsets.all(5),
              leading: const Icon(Icons.person),
              title: const Text('About You',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(user.info),
            )),
        const Divider(),
        const Padding(
            padding: EdgeInsets.all(20),
            child: Text("Your Clubs",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ))),
        buildClubsDiff()
      ],
    ));
  }
}

List<String> builtjitclub() {
  List<String> clubs = [];
  for (int i = 0; i < ac.clubs.length; i++) {
    var thing = monkey[int.parse(ac.clubs[i]) + 1];
    clubs.add(thing[1]);
  }
  return clubs;
}

Widget buildClubsDiff() {
  List<Widget> clubs = [];
  for (int i = 0; i < ac.clubs.length; i++) {
    var thing = monkey[int.parse(ac.clubs[i]) + 1];
    clubs.add(Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Card(
            elevation: 3,
            child: ListTile(
                tileColor: Colors.grey[50],
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset("assets/bxsci-clubs-logo.png")),
                title: Text(thing[1]),
                subtitle: Text(thing[4])))));
  }
  return Column(children: clubs);
}
