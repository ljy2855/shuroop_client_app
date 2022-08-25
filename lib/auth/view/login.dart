import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shuroop_client_app/auth/provider/token.dart';
import 'package:shuroop_client_app/auth/view/sign_up.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shuroop_client_app/url.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmailCheck = false;
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 30,
          right: 15,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.close,
              color: ZeplinColors.base_icon_gray,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                width: 48.59,
                height: 58.16,
              ),
              const Text(
                "어디에서나",
                style: TextStyle(
                  fontFamily: 'IBMPlexSans',
                  color: ZeplinColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.012,
                ),
              ),
              const Text(
                "당신의 우산이 되어줄",
                style: TextStyle(
                  fontFamily: 'IBMPlexSans',
                  color: ZeplinColors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.012,
                ),
              ),
              const Text(
                "슈룹",
                style: TextStyle(
                  fontFamily: 'IBMPlexSans',
                  color: ZeplinColors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 0.026,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 40)),
              Container(
                  width: 274,
                  height: 41,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                          color: ZeplinColors.text_filed_dividing_stroke_gray,
                          width: 2)),
                  child: TextField(
                    controller: emailInputController,
                    enabled: !isEmailCheck,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    ),
                  )),
              const Padding(padding: EdgeInsets.only(top: 5)),
              if (isEmailCheck)
                Container(
                    width: 274,
                    height: 41,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: ZeplinColors.text_filed_dividing_stroke_gray,
                            width: 2)),
                    child: TextField(
                      controller: passwordInputController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      ),
                    )),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: ZeplinColors.base_yellow,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22.5)),
                    ),
                    minimumSize: const Size(274, 41),
                  ),
                  onPressed: () async {
                    if (isEmailCheck) {
                      await login(emailInputController.text,
                          passwordInputController.text);
                    } else {
                      await checkEmail(emailInputController.text);
                    }
                  },
                  child: Text(isEmailCheck ? "시작하기" : "이메일로 시작하기",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "IBMPlexSans",
                          fontStyle: FontStyle.normal,
                          fontSize: 14),
                      textAlign: TextAlign.center))
            ],
          ),
        ),
      ],
    ));
  }

  checkEmail(String email) async {
    final response = await http.post(
      Uri.parse('${UrlPrefix.urls}users/check/id/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "email": email,
      }),
    );
    if (response.statusCode == 200) {
      print("email check");
      setState(() {
        isEmailCheck = true;
      });
    } else if (response.statusCode == 404) {
      print("회원가입");
      Navigator.of(context).push(MaterialPageRoute(
          builder: ((context) => SignUpPage(
                email: email,
              ))));
    }
  }

  login(String email, String password) async {
    final response = await http.post(
        Uri.parse(
          '${UrlPrefix.urls}users/login/',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }));
    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));
      setToken(data['token']);
      Navigator.pop(context);
    }
    // TODO 404 error
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }
}
