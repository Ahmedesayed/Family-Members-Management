import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fmm/helpers/firecloud.dart' as Firecloud;
import 'package:fmm/models/user.dart';
import 'package:fmm/widgets/family-member.dart';
import 'package:fmm/widgets/loading.dart';
import 'package:fmm/widgets/no-connection.dart';

class FamilyList extends StatefulWidget {
  FamilyList({Key key}) : super(key: key);

  @override
  _FamilyListState createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  @override
  void initState() {
    super.initState();
  }

  deleteMember(String docId) async {
    try {
      await Firecloud.deleteMember(docId);
    } catch (e) {
      print('error delete member $e');
      print(docId);
    }
  }

  addPoints(String docId, int points) async {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Modal BottomSheet'),
                ElevatedButton(
                  child: const Text('Close BottomSheet'),
                  onPressed: () async {
                    try {
                      await Firecloud.addPoints(docId, points + 50);
                    } catch (e) {
                      print('error add points to member $e');
                      print(docId);
                    }
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 250),
      child: StreamBuilder<QuerySnapshot<User>>(
        stream: Firecloud.membersStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.requireData;
            return ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                itemCount: data.size,
                itemBuilder: (context, index) {
                  User element = data.docs[index].data();
                  DocumentReference<User> docId = data.docs[index].reference;
                  return FamilyMember(
                    member: element,
                    docId: docId.id,
                    key: GlobalKey(),
                  );
                });
          } else if (snapshot.hasError) {
            return NoConnection();
          } else if (!snapshot.hasData) {
            return Loading();
          } else {
            return Text('');
          }
        },
      ),
    );
  }
}
