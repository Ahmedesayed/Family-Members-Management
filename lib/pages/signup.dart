import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmm/main.dart';
import 'package:fmm/helpers/app_model.dart';
import 'package:fmm/helpers/auth.dart' as AuthService;
import 'package:fmm/helpers/validators.dart';
import 'package:fmm/models/colors.dart';
import 'package:fmm/models/styles.dart';

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
  bool loading = false;

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
    this.setState(() {
      loading = true;
    });
    UserCredential u = await AuthService.signUp(emailCtrl.text, passCtrl.text);
    this.setState(() {
      loading = false;
    });
    if (u != null) await Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
          textDirection: TextDirection.rtl,
          child:Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'التسجيل',
            style: CustomStyles.boldText,
          ),
          elevation: 0,
          backgroundColor: CustomColors.bgColor,
        ),
        body:  Padding(
              padding: EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: emailCtrl,
                            decoration: const InputDecoration(
                              hintText: 'البريد الالكتروني',
                            ),
                            validator: (input) => input.isValidEmail()
                                ? null
                                : "البريد الالكتروني غير صحيح",
                          ),
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: passCtrl,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'كلمة المرور',
                              ),
                              validator: (input) => input.isValidPass()
                                  ? null
                                  : "كلمة المرور مكونة من ٦ حروف او ارقام"),
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: passVerCtrl,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'تأكيد كلمة المرور',
                              ),
                              validator: (input) => passCtrl.text ==
                                      passVerCtrl.text
                                  ? null
                                  : "تأكيد كلمة المرور لابد ان تساوي كلمة المرور"),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: ElevatedButton(
                                onPressed: !loading
                                    ? () {
                                        if (_formKey.currentState.validate()) {
                                          signup();
                                        }
                                      }
                                    : null,
                                child: !loading
                                    ? const Text('التسجبل')
                                    : CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
