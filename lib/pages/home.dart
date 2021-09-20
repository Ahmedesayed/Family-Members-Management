import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmm/models/colors.dart';
import 'package:fmm/main.dart';
import 'package:fmm/helpers/app_model.dart';
import 'package:fmm/models/styles.dart';
import 'package:fmm/widgets/bottom-navigation-bar.dart';
import 'package:fmm/widgets/floating-action-btn.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

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

  void update() => setState(() => {});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text('عائلتي',style: CustomStyles.boldText,),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionBtn(icon: Icons.qr_code_scanner,),
      bottomNavigationBar: FABBottomAppBar(
        color: CustomColors.iconColor,
        items: [
          FABBottomAppBarItem(iconData: Icons.stars_rounded, text: ''),
          FABBottomAppBarItem(iconData: Icons.layers, text: ''),
          FABBottomAppBarItem(iconData: Icons.search, text: ''),
          FABBottomAppBarItem(iconData: Icons.home_outlined, text: ''),
        ],
        onTabSelected: _selectedTab,
        backgroundColor: Colors.white,
        height: 80,
        iconSize: 35,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Tab selected : $_counter',
            ),
          ],
        ),
      ),
    );
  }

  void _selectedTab(int value) {
    this.setState(() {
    _counter = value;
    });
  }


}
