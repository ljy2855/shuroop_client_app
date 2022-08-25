
import 'package:flutter/material.dart';

import 'deposit_payment_completed.dart';

class DepositPayment extends StatelessWidget {
  const DepositPayment({Key? key}) : super(key: key);
  static const String _title = 'Radio buttons';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFFCB93F),
          centerTitle: true,
          title: const Text("보증금 결제",
              style: TextStyle(
                  fontFamily: 'IBMPlexSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: Column(
        children: [
          const Center(
            child: MyStatefulWidget(),
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
          const AgreeOnAdditionalCharges(),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(26, 16, 26, 36),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                primary: const Color(0xFFFCB93F),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DepositPaymentCompleted()));
            },
            child: (_MyStatefulWidgetState.value == 1)
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
}

class AgreeOnAdditionalCharges extends StatefulWidget {
  const AgreeOnAdditionalCharges({Key? key}) : super(key: key);

  @override
  _AgreeOnAdditionalCharges createState() => _AgreeOnAdditionalCharges();
}

class _AgreeOnAdditionalCharges extends State<AgreeOnAdditionalCharges> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 35, 0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Checkbox(
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
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static int value = 1; // 1 -> 1시간 대여, 2 -> 2시간 대여

  Widget CustomRadioButton(String text, int index) {
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
                color: (value == index) ? const Color(0xFFFCB93F) : Colors.white),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 14)),
        child: Column(
          children: [
            (text == "5,000원/24시간")
                ? Container(
              margin: const EdgeInsets.fromLTRB(0, 14, 0, 10),
              child: Icon(Icons.calendar_today_sharp,
                  size: 14,
                  color:
                  (value == index) ? const Color(0xFFFCB93F) : Colors.grey),
            )
                : Container(
              width: 50,
              margin: const EdgeInsets.fromLTRB(0, 14, 0, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.calendar_today_sharp,
                        size: 14,
                        color: (value == index)
                            ? const Color(0xFFFCB93F)
                            : Colors.grey),
                    Icon(Icons.calendar_today_sharp,
                        size: 14,
                        color: (value == index)
                            ? const Color(0xFFFCB93F)
                            : Colors.grey)
                  ]),
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  color: Colors.grey,
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 10)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomRadioButton("5,000원/24시간", 1),
            CustomRadioButton("8,000원/48시간", 2),
          ],
        ),
      ],
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
