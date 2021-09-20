import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmm/main.dart';
import 'package:fmm/helpers/app_model.dart';
import 'package:fmm/helpers/auth.dart' as AuthService;
import 'package:fmm/helpers/validators.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final passVerCtrl = TextEditingController();

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

  signup() async {
    UserCredential u = await AuthService.signUp(emailCtrl.text, passCtrl.text);
    if (u != null) await Navigator.pushNamed(context, '/home');
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Signup'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                    ),
                    validator: (input) =>
                        input.isValidEmail() ? null : "Check your email",
                  ),
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Enter your password',
                      ),
                      validator: (input) => input.isValidPass()
                          ? null
                          : "Password shouldn't be less than 6 characters"),
                           TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: passVerCtrl,
                      decoration: const InputDecoration(
                        hintText: 'Enter password verification',
                      ),
                      validator: (input) => passCtrl.text == passVerCtrl.text
                          ? null
                          : "Password verification should match your password"),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            signup();
                          }
                        },
                        child: const Text('Signup'),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}