import 'package:flutter/material.dart';

import 'deposit_payment.dart';


class DepositInformation extends StatelessWidget {
  const DepositInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFFCB93F),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 36, 180, 0),
              width: 171,
              height: 53,
              child: const Text("아직 보증금을        결제하지 않으셨네요", //이거 어케하지..
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(99.2, 88.21, 100.14, 125.45),
              width: 200,
              height: 180,
              child: Image.asset("assets/images/creditCard.png"),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 38),
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                color: const Color(0xFFFCB93F),
                iconSize: 38,
                onPressed: () {},
              ),
            ),
            Container(
              width: 198,
              height: 21,
              margin: const EdgeInsets.fromLTRB(30, 0, 175, 7),
              child: const Text("슈룹에서 우산 빌려가기",
                  style: TextStyle(
                      color: Color(0xFFFCB93F),
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.4)),
            ),
            Container(
              width: 198,
              height: 21,
              margin: const EdgeInsets.fromLTRB(30, 0, 175, 7),
              child: const Text("먼저 보증금을 결제해야 해요.",
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              width: 286,
              height: 16,
              margin: const EdgeInsets.fromLTRB(0, 0, 55, 82),
              child: const Text("하루 뒤에 반납할 수도 있고, 이틀 뒤에 반납할 수도 있어요.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 11)),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(99.2, 0, 100.14, 82),
              width: 200,
              height: 180,
              child: Image.asset("assets/images/coin.png"),
            ),
            Container(
              width: 240,
              height: 21,
              margin: const EdgeInsets.fromLTRB(0, 0, 95, 82),
              child: const Text("그 다음, 대여소의 QR을 찍어주세요.",
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(99.2, 0, 100.14, 82),
              width: 200,
              height: 180,
              child: Image.asset("assets/images/QRcodeScanner.png"),
            ),
            Container(
              width: 198,
              height: 21,
              margin: const EdgeInsets.fromLTRB(30, 0, 175, 7),
              child: const Text("대여완료되었어요!",
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              width: 280,
              height: 32,
              margin: const EdgeInsets.fromLTRB(0, 0, 62, 82),
              child: const Text(
                  "반납할 때도 대여소의 QR을 찍어주세요. 만약 약속한 기간을 넘겨서 반납한다면, 추가 금액이 발생할 수 있어요.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 11)),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(99.2, 0, 100.14, 82),
              width: 200,
              height: 180,
              child: Image.asset("assets/images/umbrella.png"),
            ),
            Container(
              width: 293,
              height: 21,
              margin: const EdgeInsets.fromLTRB(0, 0, 35, 7),
              child: const Text("그럼, 보증금을 결제하고 우산을 빌려볼까요?",
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              width: 300,
              height: 17,
              margin: const EdgeInsets.fromLTRB(0, 0, 28, 25),
              child: const Text("아래 버튼을 눌러 보증금 결제하기",
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w400,
                      fontSize: 11)),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                color: Colors.grey,
                iconSize: 38,
                onPressed: () {},
              ),
            ),
          ],
        ),
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
                  builder: (context) => const DepositPayment()
              ));
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const DepositPayment()),
              // );
            },
            child: const Text('보증금 결제하기',
                style: TextStyle(
                    fontFamily: 'IBMPlexSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 16))),
      ),
    );
  }
}
