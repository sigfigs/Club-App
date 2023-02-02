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

class Dbhelper {
  final connection = PostgreSQLConnection(
    "localhost",
    5432,
    "club_app_db",
    username: "postgres",
    password: "jeff1234",
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
    var monk = await connection.query("SELECT * FROM public.clubs");
    for (var row in monk) {
      monkey.add(row);
    }

    var user = await connection.query("SELECT * FROM public.userdata");
    for (var row in user) {
      userdata.add(row);
    }
  }

  Future<void> insertClub(
      String i, String n, String c, String m, String an, String ae) async {
    await connection.execute(
        "INSERT INTO public.monkey VALUES ('$i', '$n', '$c', '$m', '$an', '$ae');");
  }

  Future<void> insertPerson(
      String i, String o, String e, String m, String an, String ae) async {
    await connection.execute(
        "INSERT INTO public.usertable VALUES ('$i', '$o', '$e', '$m', '$an', '$ae');");
  }
}
