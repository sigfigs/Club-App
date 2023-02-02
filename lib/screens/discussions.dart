import 'package:flutter/material.dart';
import 'clubhome.dart';
import 'home.dart';
import 'signin.dart';

class Discussion extends StatefulWidget {
  final String clubName;
  final String clubDay;
  final String clubAdvisor;
  final String clubCategory;
  const Discussion(
      {super.key,
      required this.clubName,
      required this.clubDay,
      required this.clubAdvisor,
      required this.clubCategory});

  @override
  State<Discussion> createState() => _Discussion();
}

class _Discussion extends State<Discussion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class Post {
  String info;
  String author;
  String timestamp;

  Post({required this.info, required this.author, required this.timestamp});
}