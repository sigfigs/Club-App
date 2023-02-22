import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'signin.dart';
import '../user.dart';

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
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Text('${widget.clubName} Attendance'),
        ),
        body: Container(
            margin: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TableCalendar(
                  firstDay: DateTime.utc(2022, 1, 1),
                  lastDay: DateTime.utc(2030, 1, 1),
                  focusedDay: DateTime.now(),
                  calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) =>
                          buildMarker(Colors.green))),
              Container(
                  margin: EdgeInsets.fromLTRB(25, 50, 0, 0),
                  child: const Text("Key",
                      style: TextStyle(
                        fontSize: 24,
                      ))),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [buildMarker(Colors.green), Text(" = present")]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [buildMarker(Colors.red), Text(" = absent")]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [buildMarker(Colors.grey), Text(" = no meeting")]),
            ])));
  }

  Widget buildMarker(Color c) {
    return Container(
        // margin: const EdgeInsets.only(top: 40),
        height: 5,
        decoration: BoxDecoration(color: c, shape: BoxShape.circle));
  }
}

// class Attendance extends StatefulWidget {
//   final String clubName;
//   final String clubDay;
//   final String clubID;
//   const Attendance(
//       {super.key,
//       required this.clubName,
//       required this.clubDay,
//       required this.clubID});

//   @override
//   State<Attendance> createState() => _Attendance();
// }

// var clubMembers = List.generate(20, (index) => ac);

// class _Attendance extends State<Attendance> {
//   List colors = List.generate(clubMembers.length, (index) => Colors.grey[300]);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFF097969),
//           title: Text('${widget.clubName} Attendance for ${widget.clubDay}'),
//         ),
//         body: ListView.builder(
//             itemCount: clubMembers.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                   padding: const EdgeInsets.all(3), child: buildPerson(ac, index));
//             }));
//   }

//   Widget buildPerson(Userx person, int index) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15.0)),
//         color: colors[index],
//         elevation: 3,
//         child: Row(
//           children: [
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: SizedBox(
//             height: 50,
//             width: 50,
//             child: ClipRRect(
//                 borderRadius: BorderRadius.circular(50.0),
//                 child: Image.asset("assets/funnymonkeylips.png")))),
//             Text(ac.name,
//                 style: const TextStyle(fontSize: 20, color: Colors.black)),
//             const Spacer(),
//                   IconButton(
//                     onPressed: () {
//                       setState(() {
//                         colors[index] = Colors.lightGreen;
//                       });
//                     },
//                     icon: const Icon(Icons.check)),
//                    IconButton(
//                     onPressed: () {
//                       setState(() {
//                         colors[index] = Colors.red[400];
//                       });
//                     },
//                     icon: const Icon(Icons.cancel))
//           ],
//         ));
//   }
// }
