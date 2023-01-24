import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter_tutorial/model/user_model.dart';

class UserService {
  final String? uid;
  UserService({this.uid});

  //collection reference
  static final CollectionReference _userdb =
      FirebaseFirestore.instance.collection('users');

  Future executeUpdateUserData(String name, String phoneNumber) async {
    return await _userdb.doc(uid).update({
      'name': name,
      'phone_number': phoneNumber,
    });
  }

  Future updateToUsers(email, role) async {
    return await _userdb
        .doc(uid)
        .set({'role': role, 'uid': uid, 'email': email});
  }

  Future setRole(email, role) async {
    await updateToUsers(email, role);
    return await _userdb.doc(uid).update({
      'role': role,
    });
  }

  //staffData from snapshot
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    log(snapshot.data().toString());
    return UserModel(
        uid: data['uid'],
        email: data['email'],
        role: data['role'],
        firstName: data['name']);
  }

  //get staff stream
  Stream<UserModel> get userData {
    log("uid " + uid.toString());
    return _userdb.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
