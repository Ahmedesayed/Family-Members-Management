import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fmm/models/styles.dart';
import 'package:fmm/pages/home.dart';
import 'package:fmm/pages/login.dart';
import 'package:fmm/pages/signup.dart';
import 'package:get_it/get_it.dart';
import 'helpers/app_model.dart';

GetIt getIt = GetIt.instance;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getIt.registerSingleton<AppModel>(AppModelImplementation(),signalsReady: true);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Family Members Management',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white,titleTextStyle:CustomStyles.boldText,iconTheme:  IconThemeData(color: Colors.black)),
        fontFamily: 'Almarai',
      ),
      routes: <String, WidgetBuilder> {
      '/home': (BuildContext context) => HomePage(),
      '/login': (BuildContext context) => LoginPage(),
      '/signup': (BuildContext context) => SignupPage()
    },
    debugShowCheckedModeBanner: false,
      home: getIt<AppModel>().user != null ? HomePage() : LoginPage() ,
    );
  }
}


