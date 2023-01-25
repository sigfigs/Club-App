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
            automaticallyImplyLeading: false,
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

                  //my clubs
                  SizedBox(height: 30),
                  Text("My Clubs",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  SizedBox(height: 25),
                  ClubRow(),

                  //popular clubs
                  SizedBox(height: 30),
                  Text("Popular Clubs",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      )),
                  SizedBox(height: 25),
                  ClubRow(),
                ])))));
  }
}

class SectionTab extends StatefulWidget {
  final String tabBG;
  final String tabIcon;
  final String tabName;
  const SectionTab(
      {required this.tabName, required this.tabIcon, required this.tabBG});
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
                      sectionIcon: widget.tabIcon,
                      sectionBG: widget.tabBG)));
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
                                    child: Image.asset(widget.tabIcon)),
                                SizedBox(height: 10),
                                Text(widget.tabName,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis))
                              ],
                            )))))));
  }
}

class ClubRow extends StatefulWidget {
  const ClubRow({super.key});

  @override
  State<ClubRow> createState() => _ClubRow();
}

class _ClubRow extends State<ClubRow> {
  final List _items = const [
    ClubCard(
      clubName: "Filler Club",
      clubDay: "Filler Day",
      clubAdvisor: "Filler Advisor",
    ),
    ClubCard(
      clubName: "Filler Club",
      clubDay: "Filler Day",
      clubAdvisor: "Filler Advisor",
    ),
    ClubCard(
      clubName: "Filler Club",
      clubDay: "Filler Day",
      clubAdvisor: "Filler Advisor",
    )
  ];
  @override
  Widget build(BuildContext context) {
    bool isDeleteButtonVisible = false;
    int deleteButtonIndex = 0;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        itemBuilder: ((context, index) {
          return Stack(children: <Widget>[
            InkWell(
              onLongPress: () {
                setState(() {
                  isDeleteButtonVisible = true;
                  deleteButtonIndex = index;
                });
              },
              child: _items[index],
            ),
            isDeleteButtonVisible
                ? Positioned(
                    left: 0,
                    top: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        setState(() {
                          _items.removeAt(deleteButtonIndex);
                          isDeleteButtonVisible = false;
                        });
                      },
                    ),
                  )
                : Container()
          ]);
        }));
  }
}

Widget buildSections() {
  return (SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SectionTab(
            tabName: "Athletics",
            tabBG: "assets/bg/athletics-bg.png",
            tabIcon: "assets/icons/athletics-icon.png",
          ),
          // SectionTab(
          //   tabName: "Careers",
          //   tabBG: "assets/bg/career-bg.png",
          //   tabIcon: "assets/icons/careers-icon.png",
          // ),
          // SectionTab(
          //     tabName: "Cultural/Religious",
          //     tabBG: "assets/bg/culture-religion-bg.png",
          //     tabIcon: "assets/icons/culture-icon.png"),
          // SectionTab(
          //     tabName: "Education/Discussion",
          //     tabBG: "assets/bg/education-bg.png",
          //     tabIcon: "assets/icons/education-icon.png"),
          // SectionTab(
          //     tabName: "Games",
          //     tabBG: "assets/bg/games-bg.png",
          //     tabIcon: "assets/icons/games-icon.png"),
          // SectionTab(
          //     tabName: "Hobbies",
          //     tabBG: "assets/bg/hobbies-bg.png",
          //     tabIcon: "assets/icons/hobby-icon.png"),
          // SectionTab(
          //   tabName: "Arts",
          //   tabBG: "assets/bg/arts-bg.png",
          //   tabIcon: "assets/icons/arts-icon.png",
          // ),
          // SectionTab(
          //     tabName: "Publications",
          //     tabBG: "assets/bg/publication-bg.png",
          //     tabIcon: "assets/icons/publications-icon.png"),
          // SectionTab(
          //   tabName: "Science",
          //   tabBG: "assets/bg/science-bg.png",
          //   tabIcon: "assets/icons/science-icon.png",
          // ),
          // SectionTab(
          //   tabName: "Volunteer/Activism",
          //   tabBG: "assets/bg/activities-bg.png",
          //   tabIcon: "assets/icons/volunteer-icon.png",
          // ),
          // SectionTab(
          //   tabName: "Activities",
          //   tabBG: "assets/bg/activities-bg.png",
          //   tabIcon: "assets/icons/activities-icon.png",
          // ),
        ],
      )));
}

class ClubCard extends StatefulWidget {
  final String clubName;
  final String clubDay;
  final String clubAdvisor;
  const ClubCard(
      {required this.clubName,
      required this.clubDay,
      required this.clubAdvisor});

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
                            child: Image.asset("assets/bxsci-clubs-logo.png",
                                width: 120)),
                        SizedBox(height: 20),
                        Text(widget.clubName,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 20),
                        Text(
                          "lorem ipsum is dummy text. lorem ipsum is dummy text. lorem ipsum is dummy text.",
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildTag(widget.clubDay),
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
