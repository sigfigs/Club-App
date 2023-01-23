class User {
  int osis;
  String email;
  int gradyear;
  List<String> clubs;
  String role;
  String password;
  String name;
  String info;

  User(this.clubs, this.email, this.password, this.name, this.role,
      this.gradyear, this.osis, this.info);

  
  
}

class Club {
  String clubId;
  String clubName;
  String clubRoom;
  String day;
  String clubdetails;
  Map<User, bool> attendance;
  List members;
  List announcements;

  Club(this.clubId, this.clubName, this.clubRoom, this.day, this.clubdetails,
      this.attendance, this.members, this.announcements);
}
