import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmm/helpers/auth.dart' as Auth;
import 'package:fmm/helpers/firecloud.dart';
import 'package:fmm/models/colors.dart';
import 'package:fmm/main.dart';
import 'package:fmm/helpers/app_model.dart';
import 'package:fmm/models/styles.dart';
import 'package:fmm/widgets/add-member.dart';
import 'package:fmm/widgets/bottom-navigation-bar.dart';
import 'package:fmm/widgets/family-list.dart';
import 'package:fmm/widgets/floating-action-btn.dart';
import 'package:fmm/widgets/side-btn.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final tabs = [
    FABBottomAppBarItem(iconData: Icons.home_outlined, text: 'عائلتي'),
    FABBottomAppBarItem(iconData: Icons.search, text: 'البحث'),
    FABBottomAppBarItem(iconData: Icons.stars_rounded, text: 'المفضلات'),
    FABBottomAppBarItem(iconData: Icons.settings, text: 'الاعدادات'),
  ];
  @override
  void initState() {
    getIt
        .isReady<AppModel>()
        .then((_) => getIt<AppModel>().addListener(update));
    super.initState();
  }

  @override
  void dispose() {
    getIt<AppModel>().removeListener(update);
    super.dispose();
  }

  void _selectedTab(int value) {
    this.setState(() {
      selectedIndex = value;
    });
  }

  void update() => setState(() => {});

  logout() async {
    await Auth.logout();
    await Navigator.pushReplacementNamed(context, '/login');
  }

  Widget getSelectedTab() {
    switch (this.selectedIndex) {
      case 0:
        return home();
      case 3:
        return settings();
      default:
        return Text('');
    }
  }

  _addMember() async {
    showModalBottomSheet<void>(
      context: context,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: CustomStyles.appBarBottomRadius,
      ),
      builder: (BuildContext context) {
        return Container(
          height: 400,
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
                    child: SideBtn(icon:Icons.close,color: CustomColors.primaryColor,
                       onPressed: () => Navigator.pop(context),
                        isCircle: true, size: 20),
                  ),
                ),
                AddMember()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget home() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        FamilyList(),
        MaterialButton(
          onPressed: () => _addMember(),
          child: Text('إضافة فرد من العائلة'),
          height: 40,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          color: CustomColors.primaryColor,
          textColor: Colors.white,
        ),
        Text(
          'لديك (٤) دعوات',
          style: CustomStyles.lightText,
        )
      ],
    );
  }

  Widget settings() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        ListTile(
          title: Text('تسجيل الخروج'),
          tileColor: Colors.white,
          trailing: Icon(Icons.logout),
          onTap: () async {
            await logout();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          this.tabs[this.selectedIndex].text,
          style: CustomStyles.boldText,
        ),
        elevation: 0,
        backgroundColor: CustomColors.bgColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionBtn(
        icon: Icons.qr_code_scanner,
      ),
      bottomNavigationBar: FABBottomAppBar(
        color: CustomColors.iconColor,
        items: tabs,
        onTabSelected: _selectedTab,
        backgroundColor: Colors.white,
        height: 80,
        iconSize: 35,
      ),
      backgroundColor: CustomColors.bgColor,
      body:  SingleChildScrollView(child: getSelectedTab()),
    ));
  }
}
