import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fmm/models/colors.dart';
import 'package:fmm/models/styles.dart';
import 'package:fmm/models/user.dart';
import 'package:fmm/helpers/firecloud.dart' as Firecloud;
import 'package:fmm/widgets/add-point.dart';
import 'package:fmm/widgets/side-btn.dart';

class FamilyMember extends StatefulWidget {
  final User member;
  final String docId;

  FamilyMember({Key key, this.member, this.docId}) : super(key: key);

  @override
  _FamilyMemberState createState() => _FamilyMemberState();
}

class _FamilyMemberState extends State<FamilyMember> {
  @override
  void initState() {
    super.initState();
  }

  deleteMember() async {
    try {
      await Firecloud.deleteMember(widget.docId);
    } catch (e) {
      print('error delete member $e');
      print(widget.docId);
    }
  }

  _addPoints() async {
    showModalBottomSheet<void>(
      context: context,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: CustomStyles.appBarBottomRadius,
      ),
      builder: (BuildContext context) {
        return Container(
          height: 320,
          decoration: BoxDecoration(
              boxShadow: CustomStyles.appBarBottomShadow,
              color: Colors.white,
              borderRadius: CustomStyles.appBarBottomRadius),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SideBtn(
                        icon: Icons.close,
                        color: CustomColors.primaryColor,
                        onPressed: () => Navigator.pop(context),
                        isCircle: true,
                        size: 20),
                  ),
                ),
                AddPoints(docId: widget.docId, member: widget.member)
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: widget.member != null
          ? Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    child: Text(
                      widget.member.name ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                  fit: FlexFit.tight,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(
                        '${widget.member.points ?? 0}',
                        style: CustomStyles.ExtraBoldText,
                      ),
                      Text('نقطة'),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SideBtn(
                          icon: Icons.add,
                          color: CustomColors.primaryColor,
                          onPressed: _addPoints),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      SideBtn(
                          icon: Icons.delete_outline_outlined,
                          color: CustomColors.deleteBtnColor,
                          onPressed: deleteMember),
                    ],
                  ),
                ),
              ],
            )
          : Text(''),
    );
  }
}
