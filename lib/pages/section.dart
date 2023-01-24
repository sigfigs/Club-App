import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import '../clubs_db_3.dart';

class Section extends StatefulWidget {
  final String sectionName;
  final String sectionIcon;
  const Section({required this.sectionName, required this.sectionIcon});

  @override
  State<Section> createState() => _Section();
}

class _Section extends State<Section> {
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
        floatingActionButton: FloatingActionButton(
            onPressed: _showClubFormDialog,
            child: Icon(Icons.add),
            foregroundColor: Colors.green,
            elevation: 10,
            
          ),
        body: SingleChildScrollView(
            child: Column(children: [
          Image.asset('assets/sports.jpeg',
              fit: BoxFit.fill, height: height / 2.5, width: width),
          Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                  alignment: Alignment.center,
                  child: Text('All ${widget.sectionName} Clubs',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)))),
          Column(
              children: List.generate(
                  int.parse(categorySizes[widget.sectionName].toString()),
                  (index) {
            if (monkey[index][2] == widget.sectionName) {
              return (Padding(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: ClubCard(
                    // clubName: "wang",
                    // clubDay: "Monday"
                    clubName: monkey[index][3],
                    clubDay: monkey[index][4]
                  )));
            } else {
              return (Container());
            }
          })),
        ])));
  }

  void _showClubFormDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Add Club"),
        content: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Club Name"),
                // onSaved: (value) => _clubName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Category"),
                // onSaved: (value) => _category = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Meeting Day"),
                // onSaved: (value) => _meetingDay = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Advisor Name"),
                // onSaved: (value) => _advisorName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Advisor Email"),
                // onSaved: (value) => _advisorEmail = value,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text("Save"),
            onPressed: () {
              // Save the form data and close the dialog
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
}

}
