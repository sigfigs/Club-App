import 'package:flutter/material.dart';
import 'home.dart';
import '../clubs_db.dart';
import 'signin.dart';
import '../fbHelper.dart';

class Section extends StatefulWidget {
  final String sectionName;
  final String sectionIcon;
  final String sectionBG;
  const Section(
      {super.key,
      required this.sectionName,
      required this.sectionIcon,
      required this.sectionBG});

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
            foregroundColor: Colors.black,
            toolbarHeight: 75,
            backgroundColor: Colors.white,
            title:
                Text(widget.sectionName, style: TextStyle(color: Colors.black)),
            centerTitle: true),
        floatingActionButton: userData['user_type'] != 'Member'
            ? FloatingActionButton(
                onPressed: _showClubFormDialog,
                elevation: 10,
                child: const Icon(Icons.add),
              )
            : null,
        body: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = 3;
              double screenWidth = MediaQuery.of(context).size.width;
              if (screenWidth < 900) {
                crossAxisCount = 2;
              }
              if (screenWidth < 500) {
                crossAxisCount = 1;
              }
              return Column(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(widget.sectionBG,
                        fit: BoxFit.fill, height: h * 0.3),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'All ${widget.sectionName} Clubs',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  GridView.count(
                    childAspectRatio: 0.5,
                    shrinkWrap: true,
                    crossAxisCount: crossAxisCount,
                    children: getAllClubsInCategory(),
                  ),
                ],
              );
            },
          ),
        ));

  }

  List<Widget> getAllClubsInCategory() {
    List<Widget> validClubs = [];
    for (int i = 0; i < monkey.length; i++) {
      if (monkey[i][2] == widget.sectionName) {
        validClubs.add(Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: ClubCard(
                clubName: monkey[i][1],
                clubDay: monkey[i][3],
                clubAdvisor: monkey[i][4],
                clubCategory: monkey[i][2],
                clubID: monkey[i][0])));
      }
    }
    return validClubs;
  }

  void _showClubFormDialog() {
    String clubName = "default";
    String meetingDay = "default";
    String advisorName = "default";
    String advisorEmail = "default";
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Club"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: "Club Name"),
                  onSaved: (value) => clubName = value.toString(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Meeting Day"),
                  onSaved: (value) => meetingDay = value.toString(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Advisor Name"),
                  onSaved: (value) => advisorName = value.toString(),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Advisor Email"),
                  onSaved: (value) => advisorEmail = value.toString(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Save"),
              onPressed: () {
                formKey.currentState!.save();
                db.insertClub(monkey.length.toString(), clubName,
                    widget.sectionName, meetingDay, advisorName, advisorEmail);
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("Cancel"),
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
