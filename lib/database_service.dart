import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpage25/user.dart';
import 'package:midterm/models/user.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Map<String, UserModel> userMap = <String, UserModel>{};

  final StreamController<Map<String, UserModel>> _usersController =
      StreamController<Map<String, UserModel>>();

  final StreamController<Post> _postController = StreamController<Post>();

  final StreamController<List<UserModel>> _userListController =
      StreamController<List<UserModel>>();

  Stream<Map<String, UserModel>> get users => _usersController.stream;
  Stream<Post> get post => _postController.stream;
  Stream<List<UserModel>> get userList => _userListController.stream;

  DatabaseService() {
    _firestore.collection("users").snapshots().listen(_usersUpdated);
    _firestore.collection("post").doc("").snapshots().listen(_postUpdated);
  }

  void _usersUpdated(QuerySnapshot<Map<String, dynamic>> snapshot) {
    var users = _getUsersFromSnapshot(snapshot);
    _usersController.add(users);
  }

  void _postUpdated(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var users = _getPostFromSnapshot(snapshot);
    _postController.add(users);
  }

  Map<String, UserModel> _getUsersFromSnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    for (var element in snapshot.docs) {
      UserModel user = UserModel.fromJson(element.id, element.data());
      userMap[user.id] = user;
    }

    return userMap;
  }

  Post _getPostFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Post post = Post.fromJson(snapshot.data()!);
    return post;
  }
}

class Post {
  final String message;
  Post({required this.message});
  Post.fromJson(Map<String, dynamic> json) : this(message: json["message"]);
}
