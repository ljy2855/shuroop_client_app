import 'package:flutter/material.dart';

import 'deposit_payment.dart';

class DepositInformation extends StatelessWidget {
  DepositInformation({Key? key}) : super(key: key);
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xFFFCB93F),
          centerTitle: true,
          title: const Text("보증금 결제",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          )),
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 30),
                    child: const Text("아직 보증금을\n결제하지 않으셨네요", //이거 어케하지..
                        style: TextStyle(
                            fontFamily: 'IBMPlexSans',
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 80)),
              SizedBox(
                width: 200,
                height: 180,
                child: Image.asset("assets/images/creditCard.png"),
              ),
              Container(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  color: const Color(0xFFFCB93F),
                  iconSize: 38,
                  onPressed: () {},
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("슈룹에서 우산 빌려가기",
                          style: TextStyle(
                              color: Color(0xFFFCB93F),
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text("먼저 보증금을 결제해야 해요.",
                          style: TextStyle(
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text("하루 뒤에 반납할 수도 있고, 이틀 뒤에 반납할 수도 있어요.",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'IBMPlexSansKR',
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 80)),
              Container(
                margin: const EdgeInsets.fromLTRB(99.2, 0, 100.14, 82),
                width: 200,
                height: 180,
                child: Image.asset("assets/images/coin.png"),
              ),
              Row(
                children: const [
                  Text("그 다음, 대여소의 QR을 찍어주세요.",
                      style: TextStyle(
                          fontFamily: 'IBMPlexSans',
                          fontWeight: FontWeight.w600,
                          fontSize: 16)),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 80)),
              Container(
                margin: const EdgeInsets.fromLTRB(99.2, 0, 100.14, 82),
                width: 200,
                height: 180,
                child: Image.asset("assets/images/QRcodeScanner.png"),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("대여완료되었어요!",
                          style: TextStyle(
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Padding(padding: EdgeInsets.only(top: 8)),
                      Text(
                          "반납할 때도 대여소의 QR을 찍어주세요. 만약 약속한 기간을 \n넘겨서 반납한다면, 추가 금액이 발생할 수 있어요.",
                          maxLines: 2,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(99.2, 0, 100.14, 82),
                width: 200,
                height: 180,
                child: Image.asset("assets/images/umbrella.png"),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("그럼, 보증금을 결제하고 우산을 빌려볼까요?",
                          style: TextStyle(
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                      Text("아래 버튼을 눌러 보증금 결제하기",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'IBMPlexSans',
                              fontWeight: FontWeight.w400,
                              fontSize: 12)),
                    ],
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  color: Colors.grey,
                  iconSize: 38,
                  onPressed: () => moveToBottomScroll(scrollController),
                ),
              ),
            ],
          ),
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const DepositPayment()));
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

  moveToBottomScroll(ScrollController controller) {
    controller.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }
}
