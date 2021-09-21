import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fmm/helpers/app_model.dart';
import 'package:fmm/helpers/validators.dart';
import 'package:fmm/main.dart';
import 'package:fmm/helpers/auth.dart' as AuthService;
import 'package:fmm/models/colors.dart';
import 'package:fmm/models/styles.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
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

  login() async {
    this.setState(() {
      loading = true;
    });
    UserCredential u = await AuthService.login(emailCtrl.text, passCtrl.text);
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
            'الدخول',
            style: CustomStyles.boldText,
          ),
          elevation: 0,
          backgroundColor: CustomColors.bgColor,
        ),
        body:  Padding(
              padding: EdgeInsets.fromLTRB(16, 50, 16, 0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'اهلا بكم في تطبيق تحكم افراد العائلة ، برجا التسجيل.',
                      style: CustomStyles.boldText,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 50),
                      child: Form(
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
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: ElevatedButton(
                                  onPressed: !loading
                                      ? () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            login();
                                          }
                                        }
                                      : null,
                                  child: !loading
                                      ? const Text('الدخول')
                                      : CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('لا يوجد لديك حساب؟'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/signup');
                                      },
                                      child: const Text('إنشاء حساب جديد'),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
