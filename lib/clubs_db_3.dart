import 'package:postgres/postgres.dart';

List<List<dynamic>> ids = [];
List<List<dynamic>> clubNames = [];
List<List<dynamic>> categorys = [];
List<List<dynamic>> meetingDays = [];
List<List<dynamic>> advisorNames = [];
List<List<dynamic>> advisorEmails = [];

void main() async {
  var connection = PostgreSQLConnection(
    "localhost",
    5432,
    "clubappdb",
    username: "postgres",
    password: "noor2005",
  );
  await connection.open();

  ids = await connection.query("SELECT id FROM clubs");
  clubNames = await connection.query("SELECT clubname FROM clubs");
  categorys = await connection.query("SELECT category FROM clubs");
  meetingDays = await connection.query("SELECT meetingday FROM clubs");
  advisorNames = await connection.query("SELECT advisorname FROM clubs");
  advisorEmails = await connection.query("SELECT advisoremail FROM clubs");
}
