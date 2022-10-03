import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:dotted_line/dotted_line.dart';

class ReturnCompleted extends StatelessWidget {
  ReturnCompleted({Key? key}) : super(key: key);
  String paymentAmount = "0"; //추가 지불 금액
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ZeplinColors.return_alert_background,
          centerTitle: true,
          title: const Text(
            "반납 완료",
            style: TextStyle(
              fontFamily: 'IBMPlexSansKR',
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          )),
      body: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(30, 30, 0, 0),
                child: const Text("우산을 반납했어요!",
                    style: TextStyle(
                      fontFamily: 'IBMPlexSansKR',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ))),
            Container(
                margin: const EdgeInsets.fromLTRB(120, 20, 120, 20),
                color: Colors.transparent,
                child: const Image(
                  image: AssetImage('assets/images/umbrella.png'),
                )),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 10),
              child: Icon(
                Icons.access_time_outlined,
                color: paymentAmount.compareTo("0").isEven
                    ? ZeplinColors.black
                    : ZeplinColors.base_yellow,
              ),
            ),
            Container(
              //현재 시간 + 결재시간 계산
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(
                  paymentAmount.compareTo("0").isEven
                      ? "보증금이 환급되었어요"
                      : "추가 금액이 발생했어요",
                  style: TextStyle(
                    color: paymentAmount.compareTo("0").isEven
                        ? ZeplinColors.black
                        : ZeplinColors.base_yellow,
                    fontFamily: 'IBMPlexSansKR',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  )),
            ),
            Container(
              //현재 시간 + 결재시간 계산
              margin: const EdgeInsets.fromLTRB(30, 7, 30, 0),
              child: Text(
                paymentAmount.compareTo("0").isEven
                    ? "약속한 시간을 지켜주셨군요! 덕분에 더 많은 사람들이 우산을 빌릴 수 있게 되었어요."
                    : "약속한 시간을 조금 넘기셨군요. 시간에 따라 추가 요금이 계산되었어요.",
                style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF878787),
                    fontWeight: FontWeight.w400),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.fromLTRB(0, 67, 0, 0),
              child: IconButton(
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                color: const Color(0xFFFCB93F),
                iconSize: 38,
                onPressed: () => moveToBottomScroll(scrollController),
              ),
            ),
            Container(
              width: 400,
              height: 580,
              margin: const EdgeInsets.fromLTRB(30, 64, 29, 0),
              child: Card(
                elevation: 10.0,
                color: ZeplinColors.background_gray,
                child: Column(
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: const Image(
                          width: 42,
                          height: 45,
                          image:
                              AssetImage('assets/images/shuroop_logo_Text.png'),
                        )),
                    Container(
                      alignment: Alignment.centerRight,
                      margin: const EdgeInsets.fromLTRB(0, 32, 30, 7),
                      child: const Text("2022-08-08 12:30:21"),
                    ),
                    const DottedLine(
                      lineLength: 300,
                      dashLength: 10,
                      lineThickness: 0.8,
                      dashColor: ZeplinColors.inactivated_gray,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 12, 0, 0),
                            child: const Text("대여시각"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 22, 0),
                            child: const Text("2022-08-08 12:30:01"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 12, 0, 0),
                            child: const Text("반납시각"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 22, 0),
                            child: const Text("2022-08-08 12:30:21"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 12, 0, 7),
                            child: const Text("연체시간"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 22, 7),
                            child: const Text("00:00:00"),
                          ),
                        ],
                      ),
                    ),
                    const DottedLine(
                      lineLength: 300,
                      dashLength: 10,
                      lineThickness: 0.8,
                      dashColor: ZeplinColors.inactivated_gray,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 12, 0, 7),
                            child: const Text("보증금액"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 22, 7),
                            child: const Text("5,000 / 24"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 12, 0, 7),
                            child: const Text("환불금액"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 22, 7),
                            child: const Text("-5,000 / 24"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 12, 0, 12),
                            child: const Text("연체금액"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 22, 12),
                            child: const Text("0"),
                          ),
                        ],
                      ),
                    ),
                    const DottedLine(
                      lineLength: 300,
                      dashLength: 10,
                      lineThickness: 0.8,
                      dashColor: ZeplinColors.inactivated_gray,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 12, 0, 12),
                            child: const Text(
                              "결제금액",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 26, 12),
                            child: Text(
                              paymentAmount,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const DottedLine(
                      lineLength: 300,
                      dashLength: 10,
                      lineThickness: 0.8,
                      dashColor: ZeplinColors.inactivated_gray,
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(22, 12, 0, 7),
                            child: const Text("결제수단"),
                          ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 12, 22, 7),
                            child: const Text("카카오페이"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                        child: const Image(
                          width: 42,
                          height: 45,
                          image: AssetImage('assets/images/logo_gray.png'),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                primary: ZeplinColors.return_theme_color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () {},
            child: const Text('확인',
                style: TextStyle(
                  fontFamily: 'IBMPlexSansKR',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ))),
      ),
    );
  }

  moveToBottomScroll(ScrollController controller) {
    controller.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 700), curve: Curves.ease);
  }
}
