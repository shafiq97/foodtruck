import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter_tutorial/model/user_model.dart';
import 'package:google_maps_flutter_tutorial/service/user_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _getUserName() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid)
        .get()
        .then((value) {
      setState(() {
        _name.text = value.data()!['name'].toString();
        _phoneNumber.text = value.data()!['phone_number'].toString();
      });
      log(_name.text);
    });
  }

  @override
  void initState() {
    super.initState();
    _getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User Profile'),
        ),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Enter name'),
                    onChanged: (value) {
                      setState(() {
                        _name.text = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _phoneNumber,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: 'Phone Number'),
                    onChanged: (value) {
                      setState(() {
                        _phoneNumber.text = value;
                      });
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save the form data to the database
                      // final databaseReference = FirebaseDatabase.instance.ref();
                      // databaseReference.child("users").push().set({
                      //   "name": _name,
                      //   "email": _email,
                      //   "password": _password,
                      // });
                      final User? user = auth.currentUser;
                      final uid = user?.uid;
                      final userService = UserService(uid: uid);
                      userService.executeUpdateUserData(
                          _name.text, _phoneNumber.text);
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            )));
  }
}
