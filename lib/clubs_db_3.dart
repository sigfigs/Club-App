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

class DatabaseHelper {
  void queryData() async {
    var connection = PostgreSQLConnection(
      "localhost",
      5432,
      "clubs",
      username: "postgres",
      password: "noor2005",
    );
    await connection.open();

    monkey = await connection.query("SELECT * FROM public.monkey");
    userdata = await connection.query("SELECT * FROM public.userdata");
    // for (int i = 0; i < clubs.length; i++) {
    //   categorySizes[clubs[i][2]] = (categorySizes[clubs[i][2]]! + 1);
    // }
    for (int i = 0; i < userdata.length; i++) {
      if (userdata[i][2] == 'user1@bxscience.edu') {
        print('monk');
      }
    }

    print(userdata[1][2]);
  }
}

// void main() async {
//   var connection = PostgreSQLConnection(
//     "localhost",
//     5432,
//     "clubs",
//     username: "postgres",
//     password: "noor2005",
//   );
//   await connection.open();

//   monkey = await connection.query("SELECT * FROM public.monkey");
//   userdata = await connection.query("SELECT * FROM public.userdata");
//   // for (int i = 0; i < clubs.length; i++) {
//   //   categorySizes[clubs[i][2]] = (categorySizes[clubs[i][2]]! + 1);
//   // }
//   for (int i = 0; i < userdata.length; i++) {
//     if (userdata[i][2] == 'user1@bxscience.edu') {
//       print('monk');
//     }
//   }

//   print(userdata[1][2]);
// }
