import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../fbHelper.dart';

fbHelper fb = fbHelper();

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

var w, h;

class _AttendanceState extends State<Attendance> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map clubsMap = userData['clubs'];

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
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
                markerBuilder: (context, day, events) {
                  //fix when taking attendance on a club that user is not part of yet (calling .length on null)
                  for (int i = 0; i < clubsMap[widget.clubID].length; i++) {
                    List presentDate = clubsMap[widget.clubID][i].split("-");
                    String m = presentDate[0];
                    String d = presentDate[1];
                    String y = presentDate[2];

                    if (day.year.toString() == y &&
                        day.month.toString() == m &&
                        day.day.toString() == d) {
                      return buildMarker(Colors.green);
                    }
                  }
                },
              ),
            ),
          ])),
      floatingActionButton: buildTakeAttendance(),
    );
  }

  final attendanceController = TextEditingController();
  Widget buildTextFieldAttendance() {
    return (Column(children: [
      TextField(
        controller: attendanceController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Paste OSIS',
        ),
      ),
      TextButton(
        child: Text("take attendance"),
        onPressed: () {
          var dt = DateTime.now();
          String date = "${dt.month}-${dt.day}-${dt.year}";
          fb.takeAttendance(widget.clubID, attendanceController.text, "$date");
        },
      )
    ]));
  }

  Widget buildTakeAttendance() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return buildTextFieldAttendance();
          },
        );
      },
      child: Icon(Icons.add),
    );
  }

  Widget buildMarker(Color c) {
    return Container(
        height: 5, decoration: BoxDecoration(color: c, shape: BoxShape.circle));
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
