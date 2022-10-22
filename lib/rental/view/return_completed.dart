import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:shuroop_client_app/rental/model/record.dart';

class ReturnCompleted extends StatelessWidget {
  ReturnCompleted({Key? key, required this.record}) : super(key: key);
  Record record;
  DateFormat dateFormat = DateFormat("y MM-dd HH:mm:ss", Platform.localeName);
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
                color: record.charge == 0
                    ? ZeplinColors.black
                    : ZeplinColors.base_yellow,
              ),
            ),
            Container(
              //현재 시간 + 결재시간 계산
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Text(record.charge == 0 ? "보증금이 환급되었어요" : "추가 금액이 발생했어요",
                  style: TextStyle(
                    color: record.charge == 0
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
                record.charge == 0
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 350,
                  child: Card(
                    elevation: 10.0,
                    color: ZeplinColors.background_gray,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.only(top: 30)),
                          Container(
                              alignment: Alignment.center,
                              child: const Image(
                                width: 42,
                                height: 45,
                                image: AssetImage(
                                    'assets/images/shuroop_logo_Text.png'),
                              )),
                          const Padding(padding: EdgeInsets.only(top: 30)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(dateFormat.format(DateTime.now())),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 7)),
                          const DottedLine(
                            lineLength: 300,
                            dashLength: 10,
                            lineThickness: 0.8,
                            dashColor: ZeplinColors.inactivated_gray,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("대여시각"),
                              Text(dateFormat.format(record.borrowTime!)),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 7)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("반납시각"),
                              Text(dateFormat.format(record.returnTime!)),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 7)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("연체시간"),
                              Text(printDuration(record.overTime!)),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          const DottedLine(
                            lineLength: 300,
                            dashLength: 10,
                            lineThickness: 0.8,
                            dashColor: ZeplinColors.inactivated_gray,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("보증금액"),
                              Text("5,000 / 24"),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 7)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("환불금액"),
                              Text("-5,000 / 24"),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 7)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("연체금액"),
                              Text("${record.charge}"),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          const DottedLine(
                            lineLength: 300,
                            dashLength: 10,
                            lineThickness: 0.8,
                            dashColor: ZeplinColors.inactivated_gray,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "결제금액",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                record.charge.toString(),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          const DottedLine(
                            lineLength: 300,
                            dashLength: 10,
                            lineThickness: 0.8,
                            dashColor: ZeplinColors.inactivated_gray,
                          ),
                          const Padding(padding: EdgeInsets.only(top: 12)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text("결제수단"),
                              Text("카카오페이"),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 53)),
                          Container(
                              alignment: Alignment.center,
                              child: const Image(
                                width: 42,
                                height: 45,
                                image:
                                    AssetImage('assets/images/logo_gray.png'),
                              )),
                          const Padding(padding: EdgeInsets.only(top: 15)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                backgroundColor: ZeplinColors.return_theme_color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
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

String printDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}
