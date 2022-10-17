import 'package:flutter/material.dart';
import 'package:shuroop_client_app/colors.dart';

import '../map/view/map.dart';

class UsageInformation extends StatelessWidget {
  UsageInformation({Key? key}) : super(key: key);
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ZeplinColors.white,
          centerTitle: true,
          title: const Text("이용 안내",
              style: TextStyle(
                  color: ZeplinColors.black,
                  fontFamily: 'IBMPlexSans',
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          leading: IconButton(
            color: ZeplinColors.black,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 198,
              height: 21,
              margin: const EdgeInsets.fromLTRB(30, 50, 0, 7),
              child: const Text("슈룹에서 우산 빌려가기",
                  style: TextStyle(
                      color: ZeplinColors.base_yellow,
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              width: 198,
              height: 21,
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 7),
              child: const Text("먼저 보증금을 결제해야 해요.",
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              width: 286,
              height: 45,
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 82),
              child: const Text("하루 뒤에 반납할 수도 있고, 이틀 뒤에 반납할 수도 있어요.",
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'IBMPlexSansKR',
                      fontSize: 12)),
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
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 82),
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
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 7),
              child: const Text("대여완료되었어요!",
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              width: 280,
              height: 32,
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 82),
              child: const Text("간단한 단계를 통해 우산을 빌릴 수 있어요!",
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
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                color: ZeplinColors.base_yellow,
                iconSize: 38,
                onPressed: () => moveToBottomScroll(scrollController),
              ),
            ),
            Container(
              width: 198,
              height: 21,
              margin: const EdgeInsets.fromLTRB(30, 50, 0, 7),
              child: const Text("우산 반납하기",
                  style: TextStyle(
                      color: Color(0xFFFCB93F),
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 15.4)),
            ),
            Container(
              width: 198,
              height: 45,
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 7),
              child: const Text("반납하기로 약속한 시간까지 대여소로 가주세요.",
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(99.2, 0, 100.14, 82),
              width: 200,
              height: 180,
              child: Image.asset("assets/images/clock.png"),
            ),
            Container(
              width: 240,
              height: 21,
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 82),
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
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 7),
              child: const Text("반납완료되었어요!",
                  style: TextStyle(
                      fontFamily: 'IBMPlexSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 16)),
            ),
            Container(
              width: 280,
              height: 32,
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 82),
              child: const Text("만약 약속한 기간을 넘겨서 반납한다면, 추가 금액이 발생할 수 있어요.",
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
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(26, 16, 26, 36),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                backgroundColor: const Color(0xFFFCB93F),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text('우산 대여하기',
                style: TextStyle(
                    fontFamily: 'IBMPlexSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 16))),
      ),
    );
  }

  moveToBottomScroll(ScrollController controller) {
    controller.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }
}
