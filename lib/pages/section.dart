import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home.dart';
import '../clubs_db_3.dart';

class Section extends StatefulWidget {
  final String sectionName;
  final String sectionIcon;
  const Section({required this.sectionName, required this.sectionIcon});


  @override
  State<Section> createState() => _Section();
}

class _Section extends State<Section> {

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Color(0xFF097969),
            title: Text(widget.sectionName),
            centerTitle: true),
        body: SingleChildScrollView(
            child: Column(children: [
          Image.asset('assets/sports.jpeg',
              fit: BoxFit.fill, height: height / 2.5, width: width),
          Padding(
              padding: EdgeInsets.all(15),
              child: Align(
                  alignment: Alignment.center,
                  child: Text('All ${widget.sectionName} Clubs',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)))),
          Column(children: 
            List.generate(10, (index){
              if(categorys[index][0] == widget.sectionName){
              return(
                Padding(
              padding: EdgeInsets.only(right: 20, left: 20), child: ClubCard())
              );
            }
            else{
              return (Container());
            }
            })
          )
        ])));
  }
}
