import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmm/helpers/app_model.dart';
import 'package:fmm/helpers/validators.dart';
import 'package:fmm/main.dart';
import 'package:fmm/helpers/auth.dart' as AuthService;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

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

  login() async {
    UserCredential u = await AuthService.login(emailCtrl.text, passCtrl.text);
    if (u != null) await Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Welcome to Family Members Management, please sign in.',
            ),
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
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            login();
                          }
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have account?'),
                          TextButton(
                            onPressed: () {
                             Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text('Signup'),
                          ),
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
