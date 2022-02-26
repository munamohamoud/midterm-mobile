import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage25/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/material.dart';
import 'package:fanpage25/user.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  fa.FirebaseAuth _auth = fa.FirebaseAuth.instance;
  User? myself;
  DatabaseService db = DatabaseService();
  @override
  Widget build(BuildContext context) {
    User? myself = DatabaseService.userMap[_auth.currentUser!.uid];
    return Scaffold(
      floatingActionButton: myself!.role == "ADMIN"
          ? FloatingActionButton(onPressed: () {})
          : null,
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong querying users");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot doc) {
            User user =
                User.fromJson(doc.id, doc.data() as Map<String, dynamic>);
            if (user.id == _auth.currentUser!.uid) {
              myself = user;
            }
            return ListTile(
              title: Text(user.displayName),
              subtitle: Text(user.role),
            );
          }).toList());
        },
      ),
    );
  }

  void thisDoesSomething() {
    DatabaseService db = DatabaseService();
    db.users.forEach((element) {
      myself = element["id"];
    });
  }
}
