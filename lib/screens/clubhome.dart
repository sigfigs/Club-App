import 'package:flutter/material.dart';
import 'package:club_app_5/clubs_db.dart';
import 'home.dart';
import 'profile.dart';
import 'discussions.dart';
import 'attendance.dart';
import '../fbHelper.dart';

var w, h;

class ClubHome extends StatefulWidget {
  final String clubName;
  final String clubDay;
  final String clubAdvisor;
  final String clubCategory;
  final String clubID;
  const ClubHome(
      {super.key,
      required this.clubName,
      required this.clubDay,
      required this.clubAdvisor,
      required this.clubCategory,
      required this.clubID});

  @override
  State<ClubHome> createState() => _ClubHomeState();
}

class _ClubHomeState extends State<ClubHome> {
  fbHelper fb = fbHelper();

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text(
            widget.clubName,
            overflow: TextOverflow.fade,
          ),
          centerTitle: true,
          actions: <Widget>[
            userData['clubs'][widget.clubID] != null ? 
            Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Attendance(
                                clubName: widget.clubName,
                                clubDay: widget.clubDay,
                                clubID: widget.clubID)));
                  }),
                  child: const Icon(Icons.perm_contact_calendar, size: 35),
                )) : Container(),
            Container(
                margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  }),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset("assets/funnymonkeylips.png")),
                ))
          ]),
      body: Container(
          margin: EdgeInsets.fromLTRB(25, 75, 25, 25),
          child: clubDetails("assets/bxsci-clubs-logo.png")),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      Discussion(clubName: widget.clubName)))),
    );
  }

  Widget clubDetails(String image) {
    return (ListView(
      children: [
        Center(
            child: CircleAvatar(
          radius: h * 0.15,
          backgroundImage: AssetImage("assets/bxsci-clubs-logo.png"),
        )),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTag(widget.clubDay),
            buildTag(widget.clubCategory),
            buildTag(widget.clubID),
          ],
        ),
        const SizedBox(height: 50),
        const Text("Overview", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
        const SizedBox(height: 25),
        const Text("Leaders", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        Column(
            children: List.generate(3, (index) {
          return Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Card(
                  elevation: 3,
                  child: ListTile(
                    tileColor: Colors.grey[50],
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset("assets/bxsci-clubs-logo.png")),
                    title: Text(widget.clubAdvisor),
                    subtitle: const Text("Advisor"),
                  )));
        })),
        const SizedBox(height: 25),
        const Text("Related Clubs",
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children:
                    buildRelatedClubs(widget.clubCategory, widget.clubID)))
      ],
    ));
  }
}

List<Widget> buildRelatedClubs(String category, String clubID) {
  List<Widget> validClubs = [];
  for (int i = 1; i < monkey.length; i++) {
    if (monkey[i][2] == category && monkey[i][0] != clubID) {
      // debugPrint(monkey[i][0] + " parameter id:$clubID");
      validClubs.add(Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: ClubCard(
              clubName: monkey[i][1],
              clubDay: monkey[i][3],
              clubAdvisor: monkey[i][4],
              clubCategory: category,
              clubID: monkey[i][0])));
    }
    if (validClubs.length == 5) break;
  }
  return validClubs;
}
