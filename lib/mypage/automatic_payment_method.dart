import 'package:flutter/material.dart';
import 'package:shuroop_client_app/colors.dart';

import '../auth/view/personal_info.dart';

class AutomaticPaymentMethod extends StatefulWidget {
  const AutomaticPaymentMethod({Key? key}) : super(key: key);

  @override
  State<AutomaticPaymentMethod> createState() => _AutomaticPaymentMethodState();
}

class _AutomaticPaymentMethodState extends State<AutomaticPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ZeplinColors.white,
          centerTitle: true,
          title: const Text("자동 결제 수단",
              style: TextStyle(
                  color: ZeplinColors.black,
                  fontFamily: 'IBMPlexSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: ZeplinColors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Container(
          margin: const EdgeInsets.fromLTRB(20, 39, 0, 0),
          child: const RadioButtons()),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                primary: ZeplinColors.base_yellow,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PersonalInfo()
              ));
            },
            child: const Text('확인',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansKR',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ))),
      ),
    );
  }
}

class RadioButtons extends StatefulWidget {
  const RadioButtons({Key? key}) : super(key: key);

  @override
  _RadioButtonsState createState() => _RadioButtonsState();
}

enum Char { A, B, C, D }
//A. 신용/체크카드 B.계좌이채 C.카카오페이 D.네이버페이

class _RadioButtonsState extends State<RadioButtons> {
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
              print(_char.name); // _char 에 담긴 값은 이렇게
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
              print(value);
            });
          },
        ),
      ],
    );
  }
}
