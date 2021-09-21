import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fmm/models/colors.dart';
import 'package:fmm/models/styles.dart';
import 'package:fmm/helpers/firecloud.dart' as Firecloud;

class AddMember extends StatefulWidget {
  AddMember({Key key}) : super(key: key);

  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 final nameCtrl = TextEditingController();
 bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  addMember() async {
    this.setState(() {
      loading = true;
    });
    try {
      await Firecloud.addMember(nameCtrl.text, '');
      Navigator.pop(context);
    } catch (e) {
      print('error add member $e');
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
                'إضافة فرد من العائلة',
                style: CustomStyles.boldText,
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: nameCtrl,
                      decoration: const InputDecoration(
                          hintText: 'الاسم',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      validator: (input) =>
                          input.isNotEmpty ? null : "الاسم غير صحيح",
                    ),
                    Center(
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: MaterialButton(
                            onPressed: !loading
                                ? () {
                                    if (_formKey.currentState.validate()) {
                                      addMember();
                                    }
                                  }
                                : null,
                            child: !loading
                                ? Text('إضافة')
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