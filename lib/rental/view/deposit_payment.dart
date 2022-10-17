import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shuroop_client_app/colors.dart';
import 'package:shuroop_client_app/url.dart';
import 'deposit_payment_completed.dart';
import 'package:shuroop_client_app/auth/provider/token.dart';

class DepositPayment extends StatefulWidget {
  const DepositPayment({Key? key}) : super(key: key);

  @override
  State<DepositPayment> createState() => _DepositPaymentState();
}

class _DepositPaymentState extends State<DepositPayment> {
  int value = 1; // 1 -> 1시간 대여, 2 -> 2시간 대여
  bool _isChecked = false;

  Widget agreeOnAdditionalCharges() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 35, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all(const Color(0xFFFCB93F)),
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  }),
            ],
          ),
        ),
        Container(
          width: 23,
          height: 16,
          margin: const EdgeInsets.fromLTRB(0, 30, 3, 0),
          child: const Text("필수",
              style: TextStyle(
                  color: Color(0xFFFCB93F),
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 12)),
        ),
        Container(
          width: 235,
          height: 16,
          margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
          child: const Text("대여 시간 초과시 추가 요금 발생에 동의합니다.",
              style: TextStyle(
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 12)),
        ),
      ],
    );
  }

  Widget customRadioButton(String text, int index) {
    return OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
          });
        },
        style: OutlinedButton.styleFrom(
            backgroundColor:
                (value == index) ? Colors.transparent : Colors.black12,
            side: BorderSide(
                color:
                    (value == index) ? const Color(0xFFFCB93F) : Colors.white),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 14)),
        child: SizedBox(
          height: 100,
          width: 124,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (text == "5,000원/24시간")
                  ? Icon(Icons.calendar_today_outlined,
                      size: 20,
                      color: (value == index)
                          ? const Color(0xFFFCB93F)
                          : Colors.grey)
                  : SizedBox(
                      width: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                size: 20,
                                color: (value == index)
                                    ? const Color(0xFFFCB93F)
                                    : Colors.grey),
                            Icon(Icons.calendar_today_outlined,
                                size: 20,
                                color: (value == index)
                                    ? const Color(0xFFFCB93F)
                                    : Colors.grey)
                          ]),
                    ),
              Padding(padding: EdgeInsets.only(top: 13)),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFFCB93F),
          centerTitle: true,
          title: const Text("보증금 결제",
              style: TextStyle(
                  fontFamily: 'IBMPlexSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 24,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Column(
        children: [
          Center(
            child: Column(
              children: <Widget>[
                Container(
                  width: 39,
                  height: 21,
                  margin: const EdgeInsets.fromLTRB(0, 39, 291, 7),
                  child: const Text("보증금",
                      style: TextStyle(
                          fontFamily: 'IBMPlexSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 14)),
                ),
                Container(
                  width: 197,
                  height: 13,
                  margin: const EdgeInsets.fromLTRB(0, 0, 133, 25),
                  child: const Text("대여소에서 우산을 빌려가는 시간부터 계산돼요.",
                      style: TextStyle(
                          color: ZeplinColors.inactivated_gray,
                          fontFamily: 'IBMPlexSans',
                          fontWeight: FontWeight.w400,
                          fontSize: 10)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customRadioButton("5,000원/24시간", 1),
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    customRadioButton("8,000원/48시간", 2),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 52,
            height: 21,
            margin: const EdgeInsets.fromLTRB(0, 39, 277, 5),
            child: const Text("결제수단",
                style: TextStyle(
                    fontFamily: 'IBMPlexSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 14)),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: const RadioButtons(),
          ),
          agreeOnAdditionalCharges(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(26, 16, 26, 36),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                backgroundColor: (_isChecked == true)
                    ? const Color(0xFFFCB93F)
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              if (_isChecked) {
                payment().then((value) => Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) =>
                            const DepositPaymentCompleted())));
              }
            },
            child: (value == 1)
                ? const Text('5,000원 결제하기',
                    style: TextStyle(
                        fontFamily: 'IBMPlexSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16))
                : const Text('8,000원 결제하기',
                    style: TextStyle(
                        fontFamily: 'IBMPlexSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16))),
      ),
    );
  }

  Future<void> payment() async {
    String? token;
    await getToken().then((value) {
      token = value;
    });
    final response = await http.post(
        Uri.parse(
          '${UrlPrefix.urls}users/pay/',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Token $token'
        },
        body: jsonEncode({
          "day": value,
        }));
  }
}

class RadioButtons extends StatefulWidget {
  const RadioButtons({Key? key}) : super(key: key);

  @override
  RadioButtonsState createState() => RadioButtonsState();
}

enum Char { A, B, C, D }
//A. 신용/체크카드 B.계좌이채 C.카카오페이 D.네이버페이

class RadioButtonsState extends State<RadioButtons> {
  Char _char = Char.A; // 라디오 버튼의 선택 초기화

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          activeColor: const Color(0xFFFCB93F),
          title: const Text("신용/체크카드"),
          value: Char.A,
          groupValue: _char,
          onChanged: (Char? value) {
            setState(() {
              _char = value!;
            });
          },
        ),
        RadioListTile(
          activeColor: const Color(0xFFFCB93F),
          title: const Text("계좌이체"),
          value: Char.B,
          groupValue: _char,
          onChanged: (Char? value) {
            setState(() {
              _char = value!;
            });
          },
        ),
        RadioListTile(
          activeColor: const Color(0xFFFCB93F),
          title: const Text("카카오페이"),
          value: Char.C,
          groupValue: _char,
          onChanged: (Char? value) {
            setState(() {
              _char = value!;
            });
          },
        ),
        RadioListTile(
          activeColor: const Color(0xFFFCB93F),
          title: const Text("네이버페이"),
          value: Char.D,
          groupValue: _char,
          onChanged: (Char? value) {
            setState(() {
              _char = value!;
            });
          },
        ),
      ],
    );
  }
}
