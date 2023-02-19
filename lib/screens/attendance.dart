import 'package:flutter/material.dart';
import 'signin.dart';
import 'package:club_app_5/user.dart';

class Attendance extends StatefulWidget {
  final String clubName;
  final String clubDay;
  final String clubID;
  const Attendance(
      {super.key,
      required this.clubName,
      required this.clubDay,
      required this.clubID});

  @override
  State<Attendance> createState() => _Attendance();
}

var clubMembers = List.generate(20, (index) => ac);

class _Attendance extends State<Attendance> {
  List colors = List.generate(clubMembers.length, (index) => Colors.grey[300]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF097969),
          title: Text('${widget.clubName} Attendance for ${widget.clubDay}'),
        ),
        body: ListView.builder(
            itemCount: clubMembers.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.all(3), child: buildPerson(ac, index));
            }));
  }

  Widget buildPerson(Userx person, int index) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0)),
        color: colors[index],
        elevation: 3,
        child: Row(
          children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
            height: 50,
            width: 50,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.asset("assets/funnymonkeylips.png")))),
            Text(ac.name,
                style: const TextStyle(fontSize: 20, color: Colors.black)),
            const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        colors[index] = Colors.lightGreen;
                      });
                    },
                    icon: const Icon(Icons.check)),
                   IconButton(
                    onPressed: () {
                      setState(() {
                        colors[index] = Colors.red[400];
                      });
                    },
                    icon: const Icon(Icons.cancel))
          ],
        ));
  }
}
