import 'package:flutter/material.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:shuroop_client_app/rental/view/scanner.dart';

class DepositPaymentCompleted extends StatelessWidget {
  const DepositPaymentCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCB93F),
        centerTitle: true,
        title: const Text("결제 완료",
            style: TextStyle(
                fontFamily: 'IBMPlexSans',
                fontSize: 20,
                fontWeight: FontWeight.w700)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("보증금 결제에 성공했어요!",
              style: TextStyle(
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16)),
          Container(
            width: 120,
            height: 120,
            margin: const EdgeInsets.fromLTRB(0, 70, 0, 0),
            child: Image.asset("assets/images/check.png"),
          ),
          const Padding(padding: EdgeInsets.only(top: 60)),
          const Text("우산 대여소로 가볼까요?",
              style: TextStyle(
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w400,
                  fontSize: 12)),
          Container()
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(26, 16, 26, 36),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(147, 45),
                    elevation: 0,
                    backgroundColor: ZeplinColors.soft_suggestion_background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () =>
                    Navigator.popUntil(context, (route) => route.isFirst),
                child: const Text('지도보기',
                    style: TextStyle(
                        fontFamily: 'IBMPlexSans',
                        fontWeight: FontWeight.w700,
                        color: ZeplinColors.sub_text,
                        fontSize: 16))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(147, 45),
                    elevation: 0,
                    backgroundColor: const Color(0xFFFCB93F),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const QRScanPage(
                              type: QRScanType.borw,
                            )))),
                child: const Text('대여하기',
                    style: TextStyle(
                        fontFamily: 'IBMPlexSans',
                        fontWeight: FontWeight.w700,
                        fontSize: 16)))
          ],
        ),
      ),
    ));
  }
}
