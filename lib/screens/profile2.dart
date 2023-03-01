import 'package:flutter/material.dart';
import '../fbHelper.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 75,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const Text("SciClubs",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: <Widget>[
              Container(
                  margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
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
        body: Column(
          children: [
            SizedBox(height: 50),
            buildProfile(),
            buildData(),
            buildAboutMe()
          ],
        ));
  }

  Widget buildProfile() {
    return Column(children: [
      CircleAvatar(
          radius: 10, child: Image.asset("assets/funnymonkeylips.png")),
      Text(userData['full_name'],
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      Text(userData['osis'],
          style: TextStyle(
              fontSize: 10,
              color: Colors.grey[400],
              fontWeight: FontWeight.w400)),
      Text(userData['bxscience_email'],
          style: TextStyle(
              fontSize: 10,
              color: Colors.grey[300],
              fontWeight: FontWeight.w300)),
    ]);
  }

  Widget buildData() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text("5 clubs"),
      Text(userData['graduation_year']),
      Text(userData['official_class'])
    ]);
  }

  Widget buildAboutMe() {
    return Column(children: [Text("About Me")]);
  }
}
