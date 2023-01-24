import 'package:flutter/cupertino.dart';
import 'package:postgres/postgres.dart';

List<List<dynamic>> monkey = [];
List<List<dynamic>> userdata = [];
Map<String, int> categorySizes = {
  "Athletics": 0,
  "Careers": 0,
  "Cultural/Religious": 0,
  "Education/Discussion": 0,
  "Games": 0,
  "Hobbies": 0,
  "Arts": 0,
  "Publications": 0,
  "Science": 0,
  "Volunteer/Activism": 0,
  "Activities": 0
};

void main() async {
  final connection = PostgreSQLConnection(
    "localhost",
    5432,
    "clubs",
    username: "postgres",
    password: "noor2005",
  );
  await connection.open();

  // ids = await connection.query("SELECT id FROM clubs");
  // clubNames = await connection.query("SELECT clubname FROM clubs");
  // categorys = await connection.query("SELECT category FROM clubs");
  // meetingDays = await connection.query("SELECT meetingday FROM clubs");
  // advisorNames = await connection.query("SELECT advisorname FROM clubs");
  // advisorEmails = await connection.query("SELECT advisoremail FROM clubs");
  monkey = await connection.query("SELECT * FROM public.monkey");
  userdata = await connection.query("SELECT * FROM public.userdata");
  // for (int i = 0; i < clubs.length; i++) {
  //   categorySizes[clubs[i][2]] = (categorySizes[clubs[i][2]]! + 1);
  // }
  // for (int i = 0; i < userdata.length; i++) {
  //   if (userdata[i][2] == 'user1@bxscience.edu') {
  //     print('monk');
  //   }
  // }

  // print(userdata[1][2]);
}

class Dbhelper {
  List<List<dynamic>> monkey = [];
  List<List<dynamic>> userdata = [];
  Map<String, int> categorySizes = {
    "Athletics": 0,
    "Careers": 0,
    "Cultural/Religious": 0,
    "Education/Discussion": 0,
    "Games": 0,
    "Hobbies": 0,
    "Arts": 0,
    "Publications": 0,
    "Science": 0,
    "Volunteer/Activism": 0,
    "Activities": 0
  };
  final connection = PostgreSQLConnection(
    "localhost",
    5432,
    "clubs",
    username: "postgres",
    password: "noor2005",
  );

  Future<void> initDb() async {
    try {
      await connection.open();
      debugPrint("Database Connected!");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> getData() async {
    var monk = await connection.query("SELECT * FROM public.monkey");
    for (var row in monk) {
      monkey.add(row);
    }

    var user = await connection.query("SELECT * FROM public.userdata");
    for (var row in user) {
      userdata.add(row);
    }

  }
}
