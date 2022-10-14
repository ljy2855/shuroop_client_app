import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shuroop_client_app/auth/provider/token.dart';
import 'package:shuroop_client_app/url.dart';

import '../../colors.dart';

class SignUpPage extends StatefulWidget {
  final String email;

  const SignUpPage({Key? key, required this.email}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();

  late String email;
  String password = '';
  String passwordcheck = '';

  final passwordInputController = TextEditingController();
  final passwordCheckInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Scaffold(
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
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  renderTextFormFeild(
                      hintLabel: "이메일",
                      initialValue: email,
                      onSaved: (val) {
                        email = val!;
                      },
                      validator: (val) {
                        if (val.toString().isEmpty) {
                          return "이메일을 입력해주세요";
                        } else {
                          return null;
                        }
                      }),
                  const Padding(padding: EdgeInsets.only(top: 11)),
                  renderTextFormFeild(
                      controller: passwordInputController,
                      hintLabel: "비밀번호",
                      onSaved: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      validator: (val) {
                        if (val.toString().length < 6) {
                          return "6자리 이상";
                        }
                        return null;
                      }),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  renderTextFormFeild(
                      controller: passwordCheckInputController,
                      hintLabel: "비밀번호 확인",
                      onSaved: (val) {},
                      validator: (val) {
                        if (val != password) {
                          return "일치하지않음";
                        } else {
                          return null;
                        }
                      }),
                  const Padding(padding: EdgeInsets.only(top: 18)),
                  TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: ZeplinColors.base_yellow,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22.5)),
                        ),
                        minimumSize: const Size(274, 41),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          await signUpRequest(email, password).then(
                            (value) => Navigator.popUntil(
                                context, (route) => route.isFirst),
                          );
                        }
                      },
                      child: const Text("시작하기",
                          style: TextStyle(
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
        )));
  }

  renderTextFormFeild({
    TextEditingController? controller,
    required String hintLabel,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
    String? initialValue,
  }) {
    return SizedBox(
        width: 274,
        child: TextFormField(
          onChanged: onSaved,
          validator: validator,
          controller: controller,
          initialValue: initialValue,
          readOnly: controller == null ? true : false,
          obscureText: controller != null || false,
          decoration: InputDecoration(
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: ZeplinColors.text_filed_dividing_stroke_gray,
                  width: 2),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: ZeplinColors.text_filed_dividing_stroke_gray,
                  width: 2),
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: ZeplinColors.text_filed_dividing_stroke_gray,
                  width: 2),
            ),
            hintText: hintLabel,
            helperText: hintLabel == "비밀번호" ? "6자리 이상" : null,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(
                  color: ZeplinColors.text_filed_dividing_stroke_gray,
                  width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ));
  }

  Future<void> signUpRequest(String email, String password) async {
    final response = await http.post(
        Uri.parse(
          '${UrlPrefix.urls}users/sign-up/',
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
      await setToken(data['token']);
    }
  }
}
