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
  final String? uid;
  Dbhelper({this.uid});

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
      getData();

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
        "INSERT INTO public.clubs VALUES ('$i', '$n', '$c', '$m', '$an', '$ae');");
  }

  Future<void> deleteClub(String clubID) async {
    await connection.execute("DELETE FROM public.clubs WHERE id = '$clubID';");
  }

  Future<void> joinClub(String newClubID, String userID) async {
    await connection.execute(
        "UPDATE public.clubs SET clubs = concat(clubs, ' $newClubID') WHERE id = '$userID';");
  }

  Future<void> leaveClub(String newClubID, String userID) async {
    await connection.execute(
        "UPDATE public.clubs SET clubs = concat(clubs, ' $newClubID') WHERE id = '$userID';");
  }

  Future<void> insertPerson(
      String i, String o, String e, String m, String an, String ae) async {
    await connection.execute(
        "INSERT INTO public.userdata VALUES ('$i', '$o', '$e', '$m', '$an', '$ae');");
  }
}
