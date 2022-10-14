import 'package:flutter/material.dart';
import '../../colors.dart';

//Notification 은 flutter에 이미 있음
// ignore: camel_case_types
class Notification_ extends StatelessWidget {
  const Notification_({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> notification = <String>[
      '우산 대여 시간을 넘겼어요. 추가금액이 발생하니 유의하세요.',
      '1시간 후에 우산 대여 시간이 끝나요! 주변 대여소에서 우산을 반납해보세요.',
      '8월 23일 화요일 오후 12시 30분에 대여했어요! 24시간 내로 반납하는 것을 잊지 마세요.',
      '오후에 소나기가 올 것 같아요. 슈룹에서 우산을 빌려보세요.'
    ];
    final List<String> datesAndTimes = <String>['지금', '1시간 전', '1일 전', '1일 전'];

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: ZeplinColors.white,
                centerTitle: true,
                title: const Text("알림",
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
                itemCount: notification.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.fromLTRB(30, 23, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 3, 10, 0),
                                  child: Image.asset(
                                      "assets/images/logo_line.png"),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        width: 300,
                                        child: Text(notification[index],
                                            style: const TextStyle(
                                                color: ZeplinColors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400))),
                                    Text(datesAndTimes[index],
                                        style: const TextStyle(
                                            color:
                                                ZeplinColors.inactivated_gray,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                })));
  }
}
