import 'package:flutter/material.dart';
import 'package:club_app_5/clubs_db_3.dart';
import 'clubhome.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _Search();
}

class _Search extends State<Search> {
  String search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            toolbarHeight: 80,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text("Search Clubs",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            centerTitle: true),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Search a Club',
                  ),
                  onChanged: (text) {
                    setState(() => search = text.toLowerCase());
                  },
                )),
            buildClubsDiff(search)
          ],
        )));
  }

  Widget buildClubsDiff(String value) {
    List<Widget> clubs = [];
    for (int i = 0; i < monkey.length; i++) {
      var row = monkey[i];
      if (!row[1].toLowerCase().contains(value.toLowerCase())) continue;
      clubs.add(GestureDetector(
          onTap: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClubHome(
                          clubName: row[1],
                          clubDay: row[3],
                          clubAdvisor: row[4],
                          clubCategory: row[2],
                          clubID: row[0],
                        )));
          }),
          child: smallClub(row)));
    }
    return Column(children: clubs);
  }

  Widget smallClub(List row) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Card(
            elevation: 0,
            child: ListTile(
                tileColor: Colors.grey[50],
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.asset("assets/bxsci-clubs-logo.png")),
                title: Text(row[1]),
                subtitle: Text(row[4]))));
  }
}
