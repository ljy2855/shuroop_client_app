import 'package:flutter/material.dart';
import 'package:shuroop_client_app/colors.dart';

class AdditionalChargePayment extends StatefulWidget {
  const AdditionalChargePayment({Key? key}) : super(key: key);

  @override
  State<AdditionalChargePayment> createState() =>
      _AdditionalChargePaymentState();
}

class _AdditionalChargePaymentState extends State<AdditionalChargePayment> {
  String paymentAmount = "3,000";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: ZeplinColors.white,
            centerTitle: true,
            title: const Text("추가 요금 결제",
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
        body: paymentAmount.compareTo("0").isEven
            ? const Center(
                child: Text(
                "결제할 추가 요금이 없습니다.",
                style: TextStyle(
                    color: ZeplinColors.black,
                    fontFamily: 'IBMPlexSans',
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ))
            : Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.fromLTRB(30, 27, 0, 0),
                            child: const Text("추가요금",
                                style: TextStyle(
                                    fontFamily: 'IBMPlexSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                                child: const Text("대여시각",
                                    style: TextStyle(
                                        color: ZeplinColors.inactivated_gray,
                                        fontFamily: 'IBMPlexSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                                child: const Text("2022.08.07 12:30:01",
                                    style: TextStyle(
                                        color: ZeplinColors.inactivated_gray,
                                        fontFamily: 'IBMPlexSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                                child: const Text("반납시각",
                                    style: TextStyle(
                                        color: ZeplinColors.inactivated_gray,
                                        fontFamily: 'IBMPlexSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                                child: const Text("2022.08.08 18:30:14",
                                    style: TextStyle(
                                        color: ZeplinColors.inactivated_gray,
                                        fontFamily: 'IBMPlexSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                                child: const Text("연체시간",
                                    style: TextStyle(
                                        color: ZeplinColors.inactivated_gray,
                                        fontFamily: 'IBMPlexSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600))),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                                child: const Text("06:00:00",
                                    style: TextStyle(
                                        color: ZeplinColors.inactivated_gray,
                                        fontFamily: 'IBMPlexSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                                child: const Text("연체금액",
                                    style: TextStyle(
                                        color: ZeplinColors.black,
                                        fontFamily: 'IBMPlexSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400))),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                                child: const Text("3000원 / 6시간",
                                    style: TextStyle(
                                        color: ZeplinColors.black,
                                        fontFamily: 'IBMPlexSans',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400)))
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            alignment: Alignment.centerLeft,
                            margin: const EdgeInsets.fromLTRB(30, 39, 0, 0),
                            child: const Text("결제수단",
                                style: TextStyle(
                                    fontFamily: 'IBMPlexSans',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))),
                        Container(
                            margin: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                            child: const RadioButtons()),
                      ],
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: Visibility(
          visible: paymentAmount.compareTo("0").isOdd,
          child: Container(
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(350, 50),
                    primary: ZeplinColors.base_yellow,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const PersonalInfo()));
                },
                child: Text("$paymentAmount원 결제하기",
                    style: const TextStyle(
                      fontFamily: 'IBMPlexSansKR',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ))),
          ),
        ));
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
