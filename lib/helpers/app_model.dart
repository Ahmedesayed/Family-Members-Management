import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

abstract class AppModel extends ChangeNotifier {
  void incrementCounter();
  void setUser();
  User get user;
  int get counter;
}

class AppModelImplementation extends AppModel {
  int _counter = 0;
  User _user;

  AppModelImplementation() {
    /// lets pretend we have to do some async initilization
    Future.delayed(Duration(seconds: 1)).then((_) => getIt.signalReady(this));
    setUser();
  }

  @override
  int get counter => _counter;

  @override
  User get user => _user;

  @override
  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  @override
  void setUser() {
    _user = FirebaseAuth.instance.currentUser;
    print(_user);
    notifyListeners();
  }
}