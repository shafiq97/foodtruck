import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_installations/firebase_installations.dart';
import 'package:google_maps_flutter_tutorial/model/user_model.dart';

class UserService {
  final String? uid;
  UserService({this.uid});

  //collection reference
  static final CollectionReference _userdb =
      FirebaseFirestore.instance.collection('users');

  Future executeUpdateUserData(
      String userName, String phoneNumber, String email) async {
    return await _userdb.doc(uid).update({
      'name': userName,
      'email': email,
      'phone_number': phoneNumber,
    });
  }

  //staffData from snapshot
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    log("here");
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    log(data.toString());
    return UserModel(
      uid: data['uid'],
      email: data['email'],
    );
  }

  //get staff stream
  Stream<UserModel> get userData {
    log("uid " + uid.toString());
    return _userdb.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
