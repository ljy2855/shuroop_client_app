import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class PaymentRefundHistory extends StatelessWidget {
  const PaymentRefundHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> services = <String>[
      '보증금 5000원/24시간',
      '보증금 8000원/48시간',
      '보증금 8000원/48시간',
      '추가금액 3000원/6시간'
    ];
    final List<String> datesAndTimes = <String>[
      '2022.08.25 12:15',
      '2022.08.21 12:29',
      '2022.08.21 11:32',
      '2022.08.08 10:15'
    ];
    final List<String> states = <String>['결제', '환불', '취소된 결제', '결제'];
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: ZeplinColors.white,
                centerTitle: true,
                title: const Text("결제/환불 이력",
                    style: TextStyle(
                        color: ZeplinColors.black,
                        fontFamily: 'IBMPlexSans',
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,
                      color: ZeplinColors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            body: ListView.builder(
                itemCount: services.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.fromLTRB(30, 23, 30, 0),
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(services[index]),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  content:
                                                      SingleChildScrollView(
                                                          child: Receipt()));
                                            });
                                      },
                                      icon: const Icon(Icons.add_circle,
                                          size: 15))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    datesAndTimes[index],
                                    style: const TextStyle(
                                        color: ZeplinColors.inactivated_gray),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 3),
                                    child: Text(
                                      states[index],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: states[index] == '환불'
                                              ? ZeplinColors.black
                                              : ZeplinColors.inactivated_gray),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ZeplinColors.soft_suggestion_background)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text("보증금 5000원/24시간을 환불하시겠어요?",
                                                    style: TextStyle(
                                                        color:
                                                            ZeplinColors.black,
                                                        fontFamily:
                                                            'IBMPlexSans',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                                Text(
                                                    "슈룹에서 우산을 빌리려면 보증금 결제가 필요해요.",
                                                    style: TextStyle(
                                                        color: ZeplinColors
                                                            .inactivated_gray,
                                                        fontFamily:
                                                            'IBMPlexSans',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("취소",
                                                style: TextStyle(
                                                    color: ZeplinColors
                                                        .inactivated_gray))),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "확인",
                                            style: TextStyle(
                                                color:
                                                    ZeplinColors.base_yellow),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                '환불하기',
                                style: TextStyle(color: ZeplinColors.black),
                              ))
                        ],
                      ));
                })));
  }
}

class Receipt extends StatelessWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String paymentAmount = "0"; //추가 지불 금액
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                  image: AssetImage('assets/images/shuroop_logo_Text.png'),
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
    );
  }
}
