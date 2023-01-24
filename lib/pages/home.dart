import 'package:flutter/material.dart';
import 'clubhome.dart';
import 'section.dart';
import 'profile.dart';
import 'package:club_app_5/clubs_db_3.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var db;
  @override
  void initState() {
    super.initState();
    db = Dbhelper();
    db.initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF097969),
            title: Text("BXSCI Clubs"),
            centerTitle: true,
            actions: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 15, 10),
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => Profile()));
                    }),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset("assets/funnymonkeylips.png")),
                  ))
            ]),
        body: Container(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: (SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  Text("Club Categories",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  SizedBox(height: 25),
                  buildSections(),
                  SizedBox(height: 30),
                  Text("Popular Clubs",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  SizedBox(height: 25),
                  buildClubs(),

                  //my clubs
                  SizedBox(height: 30),
                  Text("My Clubs",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  SizedBox(height: 25),
                  buildClubs()
                ])))));
  }
}

class SectionTab extends StatefulWidget {
  final String tabName;
  const SectionTab({required this.tabName});
  @override
  State<SectionTab> createState() => _SectionTabState();
}

class _SectionTabState extends State<SectionTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: (() {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => Section(
                      sectionName: widget.tabName,
                      sectionIcon: "assets/sports.jpeg")));
        }),
        child: Container(
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 3,
                child: Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: SizedBox(
                            height: 120,
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child:
                                        Image.asset("assets/bxscilogo.jpeg")),
                                SizedBox(height: 10),
                                Text(widget.tabName,
                                maxLines: 1,
                                    style:
                                       const  TextStyle(fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))
                              ],
                            )))))));
  }
}

Widget buildSections() {
  return (SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SectionTab(tabName: "Athletics"),
          SectionTab(tabName: "Careers"),
          SectionTab(tabName: "Cultural/Religious"),
          SectionTab(tabName: "Education/Discussion"),
          SectionTab(tabName: "Games"),
          SectionTab(tabName: "Hobbies"),
          SectionTab(tabName: "Arts"),
          SectionTab(tabName: "Publications"),
          SectionTab(tabName: "Science"),
          SectionTab(tabName: "Volunteer/Activisim"),
          SectionTab(tabName: "Activities"),
        ],
      )));
}

Widget buildClubs() {
  return (SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
        3,
        ((index) {
          return ClubCard(clubName: "Athletics", clubDay: "Tuesday");
        }),
      ))));
}

class ClubCard extends StatefulWidget {
  // const ClubCard({super.key});
  final String clubName;
  final String clubDay;
  const ClubCard({required this.clubName, required this.clubDay});

  @override
  State<ClubCard> createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  @override
  Widget build(BuildContext context) {
    var sWidth = MediaQuery.of(context).size.width;
    var sHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
        onTap: (() {
          Navigator.push(
              context, new MaterialPageRoute(builder: (context) => ClubHome()));
        }),
        child: Container(
            width: sWidth,
            height: sHeight * 0.4,
            child: Card(
                elevation: 3,
                color: Color.fromARGB(255, 248, 244, 244),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset("assets/bxscilogo.jpeg",
                                width: 120)),
                        SizedBox(height: 20),
                        Text("Muslim Student Association",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(
                          "The Muslim Student Assocation (MSA) is a club that Shad is in. The Muslim Student Assocation (MSA) is a club that Shad is in.",
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildTag("Tuesday"),
                            buildTag("Medium Commitment")
                          ],
                        )
                      ]),
                ))));
  }
}

Widget buildTag(String name) {
  return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Center(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              padding: EdgeInsets.all(5.0),
              child: Text(name, style: TextStyle(color: Colors.grey[700])))));
}
