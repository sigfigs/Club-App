import 'package:flutter/material.dart';
import 'clubhome.dart';
import 'section.dart';
import 'profile.dart';
import 'package:club_app_5/clubs_db_3.dart';
import 'signin.dart';
import 'searchclub.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // var db;
  // @override
  // void initState() {
  //   super.initState();
  //   db = Dbhelper();
  //   db.initDb();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 80,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const Text("BXSCI Clubs",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            centerTitle: true,
            leading: IconButton(
              color: Colors.black,
                icon: const Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Search()));
                }),
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
            margin: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: (SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  const Text("Club Categories",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  const SizedBox(height: 25),
                  buildSections(),

                  //my clubs
                  const SizedBox(height: 30),
                  const Text("My Clubs",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  const SizedBox(height: 25),
                  buildMyClubs(),

                  //popular clubs
                  const SizedBox(height: 30),
                  const Text("Popular Clubs",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  const SizedBox(height: 25),
                  buildMyClubs(),
                ])))));
  }
}

class SectionTab extends StatefulWidget {
  final String tabBG;
  final String tabIcon;
  final String tabName;
  const SectionTab(
      {super.key,
      required this.tabName,
      required this.tabIcon,
      required this.tabBG});
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
              MaterialPageRoute(
                  builder: (context) => Section(
                      sectionName: widget.tabName,
                      sectionIcon: widget.tabIcon,
                      sectionBG: widget.tabBG)));
        }),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 3,
            child: Center(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                        height: 120,
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: Image.asset(widget.tabIcon,
                                        fit: BoxFit.fill))),
                            const SizedBox(height: 10),
                            Text(widget.tabName,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ))))));
  }
}

Widget buildMyClubs() {
  List<Widget> clubs = [];
  for (int i = 0; i < ac.clubs.length; i++) {
    var row = monkey[int.parse(ac.clubs[i]) + 1];
    clubs.add(ClubCard(
      clubName: row[1],
      clubDay: row[3],
      clubAdvisor: row[4],
      clubCategory: row[2],
      clubID: row[0],
    ));
  }
  return (SingleChildScrollView(
      scrollDirection: Axis.horizontal, child: Row(children: clubs)));
}

Widget buildSections() {
  return (SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SectionTab(
            tabName: "Athletics",
            tabBG: "assets/athletics-bg.png",
            tabIcon: "assets/athletics-icon.png",
          ),
          SectionTab(
            tabName: "Careers",
            tabBG: "assets/career-bg.png",
            tabIcon: "assets/careers-icon.png",
          ),
          SectionTab(
              tabName: "Cultural/Religious",
              tabBG: "assets/culture-religion-bg.png",
              tabIcon: "assets/culture-icon.png"),
          SectionTab(
              tabName: "Education/Discussion",
              tabBG: "assets/education-bg.png",
              tabIcon: "assets/education-icon.png"),
          SectionTab(
              tabName: "Games",
              tabBG: "assets/games-bg.png",
              tabIcon: "assets/games-icon.png"),
          SectionTab(
              tabName: "Hobbies",
              tabBG: "assets/hobbies-bg.png",
              tabIcon: "assets/hobby-icon.png"),
          SectionTab(
            tabName: "Arts",
            tabBG: "assets/arts-bg.png",
            tabIcon: "assets/arts-icon.png",
          ),
          SectionTab(
              tabName: "Publications",
              tabBG: "assets/publication-bg.png",
              tabIcon: "assets/publications-icon.png"),
          SectionTab(
            tabName: "Science",
            tabBG: "assets/science-bg.png",
            tabIcon: "assets/science-icon.png",
          ),
          SectionTab(
            tabName: "Volunteer/Activism",
            tabBG: "assets/activities-bg.png",
            tabIcon: "assets/volunteer-icon.png",
          ),
          SectionTab(
            tabName: "Activities",
            tabBG: "assets/activities-bg.png",
            tabIcon: "assets/activities-icon.png",
          ),
        ],
      )));
}

class ClubCard extends StatefulWidget {
  final String clubName;
  final String clubDay;
  final String clubAdvisor;
  final String clubCategory;
  final String clubID;
  const ClubCard(
      {super.key,
      required this.clubName,
      required this.clubDay,
      required this.clubAdvisor,
      required this.clubCategory,
      required this.clubID});

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
              context,
              MaterialPageRoute(
                  builder: (context) => ClubHome(
                        clubName: widget.clubName,
                        clubDay: widget.clubDay,
                        clubAdvisor: widget.clubAdvisor,
                        clubCategory: widget.clubCategory,
                        clubID: widget.clubID,
                      )));
        }),
        child: SizedBox(
            width: sWidth,
            height: sHeight * 0.4,
            child: Card(
                elevation: 3,
                color: Colors.white,
                // color: const Color.fromARGB(255, 248, 244, 244),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.asset("assets/bxsci-clubs-logo.png",
                                width: 120)),
                        const SizedBox(height: 20),
                        Text(widget.clubName,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        const Text(
                          "lorem ipsum is dummy text. lorem ipsum is dummy text. lorem ipsum is dummy text.",
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildTag(widget.clubDay),
                            buildTag(widget.clubCategory),
                            buildTag(widget.clubID),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: TextButton(
                            child: Text("Join"),
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.green[600])),
                            onPressed: () {
                              db.joinClub("1", widget.clubID);
                            },
                          ),
                        )
                      ]),
                ))));
  }
}

Widget buildTag(String name) {
  return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: Center(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              padding: const EdgeInsets.all(5.0),
              child: Text(name, style: TextStyle(color: Colors.grey[700])))));
}
