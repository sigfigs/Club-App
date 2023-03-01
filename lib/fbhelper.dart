import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final usersCollection = FirebaseFirestore.instance.collection('users');
FirebaseFirestore firestore = FirebaseFirestore.instance;
var firebaseUser = FirebaseAuth.instance.currentUser!;

bool isLoggedIn = false;
Map<String, dynamic> userData = {};

class fbHelper {
  fbHelper();

  Future<void> getUserData() async {
    String docID = "kvutT3X9zqR2qX5P2W14";
    DocumentSnapshot document = await usersCollection.doc(docID).get();
    userData = document.data() as Map<String, dynamic>;
    print(userData);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Signed in");
      getUserData();

      isLoggedIn = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> takeAttendance(String clubID, String osis, String date) async {
    Map clubsMap = userData['clubs'];
    final querySnapshot = await usersCollection.get();

    querySnapshot.docs.forEach((doc) {
      final o = doc.get('osis');
      if (o == '$osis' && clubsMap[clubID] == null) {
        addClub(clubID);
      }

      if (o == '$osis' && clubsMap[clubID] != null) {
        print('Found document with value "$osis": ${doc.id}');
        clubsMap[clubID].add(date);
        usersCollection
            .doc(doc.id)
            .update({'clubs': clubsMap})
            .then((value) =>
                print("Club $clubID attendance updated for $osis on $date."))
            .catchError((error) => print("Attendance updated: $error"));
      }
    });
  }

  Future<void> leaveClub(String clubID) async {
    Map clubsMap = userData['clubs'];
    clubsMap.remove(clubID);

    String docID = "kvutT3X9zqR2qX5P2W14";
    usersCollection
        .doc(docID)
        .update({'clubs': clubsMap})
        .then((value) => print("Club $clubID removed."))
        .catchError((error) => print("Failed to remove club: $error"));
    print(userData);
  }

  Future<void> addClub(String clubID) async {
    userData['clubs'][clubID] = [];

    //find a way to get the docID for the user (this is just lij12@bxscience.edu's id)
    String docID = "kvutT3X9zqR2qX5P2W14";
    usersCollection
        .doc(docID)
        .update({'clubs': userData['clubs']})
        .then((value) => print("Club $clubID added."))
        .catchError((error) => print("Failed to add club: $error"));
    print(userData);
  }
}
