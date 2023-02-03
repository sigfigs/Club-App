import 'package:flutter/material.dart';
import 'clubhome.dart';
import 'home.dart';
import 'dart:ui';
import 'signin.dart';

class Discussion extends StatefulWidget {
  final String clubName;
  const Discussion({super.key, required this.clubName});

  @override
  State<Discussion> createState() => _Discussion();
}

class _Discussion extends State<Discussion> {
  DateTime now = DateTime.now();
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  List<Post> discuss = [
    Post(author: 'Benjy', info: 'I like benjy and little kid', timestamp: 'jit')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFF097969),
          title: Text(widget.clubName),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          _showNewTaskDialog();
        }),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Overview", style: TextStyle(fontWeight: FontWeight.bold)),
          ListView.builder(
              shrinkWrap: true,
              itemCount: discuss.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: comment(discuss[index]));
              })
        ])));
  }

  Widget comment(Post post) {
    return Card(
        elevation: 3,
        child: Column(children: [
          Padding(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: Icon(Icons.person),
                trailing: Icon(Icons.menu),
                title: Text(post.author),
                subtitle: Text('Posted at:  ${post.timestamp}'),
              )),
           Padding(
              padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              child: Text(post.info, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
        ]));
  }

  void _showNewTaskDialog() {
    controller.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Post a New Comment"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: "Comment Details",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your comment.";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  setState(() {
                    discuss.add(Post(
                        info: controller.text,
                        author: ac.name,
                        timestamp:
                            now.hour.toString() + ':' + now.minute.toString()));
                    Navigator.of(context).pop();
                  });
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}

class Post {
  String info;
  String author;
  String timestamp;

  Post({required this.info, required this.author, required this.timestamp});
}
