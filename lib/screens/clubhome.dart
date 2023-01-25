import 'package:flutter/material.dart';
import 'package:club_app_5/clubs_db_3.dart';
import 'home.dart';
import 'dart:math';
import 'profile.dart';

class ClubHome extends StatefulWidget {
  final String clubName;
  final String clubDay;
  final String clubAdvisor;
  final String clubCategory;
  const ClubHome(
      {super.key,
      required this.clubName,
      required this.clubDay,
      required this.clubAdvisor,
      required this.clubCategory});

  @override
  State<ClubHome> createState() => _ClubHomeState();
}

class _ClubHomeState extends State<ClubHome> {
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
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: const Color(0xFF097969),
            title: Text(widget.clubName),
            centerTitle: true,
            actions: <Widget>[
              Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 15, 10),
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.push(
                          context,
                           MaterialPageRoute(
                              builder: (context) => const Profile()));
                    }),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Image.asset("assets/funnymonkeylips.png")),
                  ))
            ]),
        body: Container(
            margin: const EdgeInsets.all(20.0),
            child: clubDetails("assets/bxsci-clubs-logo.png")));
  }

  Widget clubDetails(String image) {
    return (ListView(
      children: [
        Image.asset(
          "assets/bxsci-clubs-logo.png",
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return buildTag(widget.clubDay);
          }),
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
        const Text("Related Clubs", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 25),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: buildRelatedClubs(widget.clubCategory)))
      ],
    ));
  }
}

List<Widget> buildRelatedClubs(String category) {
  List<Widget> validClubs = [];
  for (int i = 0; i < monkey.length; i++) {
    if (monkey[i][2] == category) {
      validClubs.add(Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: ClubCard(
            clubName: monkey[i][1],
            clubDay: monkey[i][3],
            clubAdvisor: monkey[i][4],
            clubCategory: category,
          )));
    }
  }
  Random random =  Random();
  Set<int> ratings = {};
  while (ratings.length != 5) {
    int rand = random.nextInt(validClubs.length);
    ratings.add(rand);
  }

  List<Widget> retClubs = [];
  for (int i = 0; i < ratings.length; i++) {
    retClubs.add(Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: ClubCard(
          clubName: monkey[ratings.elementAt(i)][1],
          clubDay: monkey[ratings.elementAt(i)][3],
          clubAdvisor: monkey[ratings.elementAt(i)][4],
          clubCategory: category,
        )));
  }
  return retClubs;
}