import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fmm/helpers/firecloud.dart' as Firecloud;
import 'package:fmm/models/colors.dart';
import 'package:fmm/models/styles.dart';
import 'package:fmm/models/user.dart';

class AddPoints extends StatefulWidget {
  final String docId;
  final User member;
  AddPoints({Key key, this.docId, this.member}) : super(key: key);

  @override
  _AddPointsState createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPoints> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pointsCtrl = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  addPoints() async {
    this.setState(() {
      loading = true;
    });
    try {
      await Firecloud.addPoints(
          widget.docId, widget.member.points + int.parse(pointsCtrl.text));
      Navigator.pop(context);
    } catch (e) {
      print('error add points to member $e');
      print(widget.docId);
    }
    this.setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl, child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'إرسال نقاط',
                style: CustomStyles.boldText,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'أدخل عدد النقاط المراد إرسالها إلي',
                style: CustomStyles.boldText,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                widget.member.name,
                style: CustomStyles.ExtraBoldText,
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: pointsCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'عدد النقاط',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      validator: (input) =>
                          int.parse(input) > 0 ? null : "عدد النقاط غير صحيح",
                    ),
                    Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: MaterialButton(
                            onPressed: !loading
                                ? () {
                                    if (_formKey.currentState.validate()) {
                                      addPoints();
                                    }
                                  }
                                : null,
                            child: !loading
                                ? Text('إرسال')
                                : CircularProgressIndicator(),
                            height: 40,
                            minWidth: 150,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            color: CustomColors.primaryColor,
                            textColor: Colors.white,
                          )
                          ),
                    ),
                  ],
                )
                )
          ]),
    ));
  }
}
