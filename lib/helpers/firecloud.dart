import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fmm/models/user.dart';

CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
Stream collectionStream = usersRef.snapshots();

  final membersStream = usersRef
    .withConverter<User>(
      fromFirestore: (snapshots, _) => User.fromJson(snapshots.data()),
      toFirestore: (user, _) => user.toJson(),
    ).snapshots();

Future<void> addMember(String name, String mobileNumber) {
  return usersRef
      .add({'name': name, 'points': 0, 'mobileNumber': mobileNumber})
      .then((value) => print("User Added : $value"))
      .catchError((error) => print("Failed to add user: $error"));
}

Future<void> deleteMember(String id) {
  return usersRef
      .doc(id)
      .delete()
      .then((value) => print("User Deleted"))
      .catchError((error) => print("Failed to delete user: $error"));
}

Future<void> addPoints(String id, int points) {
  return usersRef
      .doc(id)
      .update({'points': points})
      .then((value) => print("User Updated"))
      .catchError((error) => print("Failed to update user: $error"));
}

