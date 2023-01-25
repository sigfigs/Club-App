import 'package:flutter/material.dart';
import 'home.dart';
import '../clubs_db_3.dart';
import 'signin.dart';

class Section extends StatefulWidget {
  final String sectionName;
  final String sectionIcon;
  final String sectionBG;
  const Section(
      {required this.sectionName,
      required this.sectionIcon,
      required this.sectionBG});

  @override
  State<Section> createState() => _Section();
}

class _Section extends State<Section> {
  var db;
  @override
  void initState() {
    super.initState();
    db = Dbhelper();
    db.initDb();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Color(0xFF097969),
            title: Text(widget.sectionName),
            centerTitle: true),
        floatingActionButton: ac.role == 'Admin'
            ? FloatingActionButton(
                onPressed: _showClubFormDialog,
                child: Icon(Icons.add),
                elevation: 10,
              )
            : null,
        body: SingleChildScrollView(
            child: Column(children: [
          Image.asset(widget.sectionBG,
              fit: BoxFit.fill, height: height / 2.5, width: width),
          Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                  alignment: Alignment.center,
                  child: Text('All ${widget.sectionName} Clubs',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)))),
          Column(children: getAllClubsInCategory()),
        ])));
  }

  List<Widget> getAllClubsInCategory() {
    List<Widget> validClubs = [];
    for (int i = 0; i < monkey.length; i++) {
      if (monkey[i][2] == widget.sectionName) {
        validClubs.add(Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: ClubCard(
                clubName: monkey[i][1],
                clubDay: monkey[i][3],
                clubAdvisor: monkey[i][4])));
      }
    }
    return validClubs;
  }

  void _showClubFormDialog() {
    String clubName = "";
    String meetingDay = "";
    String advisorName = "";
    String advisorEmail = "";
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Club"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "Club Name"),
                  onSaved: (value) => clubName = value.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Meeting Day"),
                  onSaved: (value) => meetingDay = value.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Advisor Name"),
                  onSaved: (value) => advisorName = value.toString(),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Advisor Email"),
                  onSaved: (value) => advisorEmail = value.toString(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                _formKey.currentState!.save();
                db.insertClub(monkey.length.toString(), clubName,
                    widget.sectionName, meetingDay, advisorName, advisorEmail);
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );

    // db.insertClub(
    //     "6969", clubName, category, meetingDay, advisorName, advisorEmail);
  }
}
