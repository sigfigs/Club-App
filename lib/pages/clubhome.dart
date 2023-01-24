import 'package:flutter/material.dart';
import 'package:club_app_5/clubs_db_3.dart';
import 'home.dart';

class ClubHome extends StatefulWidget {
  const ClubHome({super.key});

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
            backgroundColor: Color(0xFF097969),
            title: Text("Club Home"),
            centerTitle: true,
            actions: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 15, 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset("assets/funnymonkeylips.png")),
              )
            ]),
        body: Container(
            margin: EdgeInsets.all(20.0),
            child: clubDetails("assets/bxscilogo.jpeg")));
  }
}

Widget clubDetails(String imagePATH) {
  return (ListView(
    children: [
      Image.asset(imagePATH),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return buildTag("Tuesday");
        }),
      ),
      SizedBox(height: 50),
      Text("Overview", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 25),
      Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."),
      SizedBox(height: 25),
      Text("Leaders", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 25),
      Column(
          children: List.generate(3, (index) {
        return Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Card(
                elevation: 3,
                child: ListTile(
                  tileColor: Colors.grey[50],
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image.asset("assets/bxscilogo.jpeg")),
                  title: Text('One-line with leading widget'),
                  subtitle: Text('Here is a second line'),
                )));
      })),
      SizedBox(height: 25),
      Text("Related Clubs", style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 25),
      buildClubs()
    ],
  ));
}
