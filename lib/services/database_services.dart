import 'package:chat_app_firebase/helper/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  late final String uid;
  DatabaseService({required this.uid});

  final CollectionReference usercollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupcollection =
      FirebaseFirestore.instance.collection("groups");

  Future savingUserData(String fullname, String email) async {
    return await usercollection.doc(uid).set({
      "fullName": fullname,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }

  // getting user data
  Future gettinguserdata(String email) async {
    QuerySnapshot snapshot =
        await usercollection.where("email", isEqualTo: email).get();
    return snapshot;
  }

  getusergroups() async {
   return await usercollection.doc(uid).snapshots();
  }

  Future creategroup(String username, String id, String groupName) async {
    DocumentReference groupdocumentReference = await groupcollection.add({
      'groupname': groupName,
      'groupIcon': '',
      'admin': '${id}_$username',
      'members': [],
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': '',
    });

    await groupdocumentReference.update({
      'members': FieldValue.arrayUnion(['${uid}_${username}']),
      'groupId': groupdocumentReference.id
    });

    DocumentReference userDocumentreference = usercollection.doc(id);
    return await userDocumentreference.update({
      'groups':
          FieldValue.arrayUnion(['${groupdocumentReference.id}_$groupName'])
    });
  }
}
