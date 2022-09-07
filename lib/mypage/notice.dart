import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuroop_client_app/colors.dart';

class Notice extends StatefulWidget {
  const Notice({Key? key}) : super(key: key);

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  List<String> entries = <String>['aa', 'bb'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ZeplinColors.white,
          centerTitle: true,
          title: const Text("공지 사항",
              style: TextStyle(
                  color: ZeplinColors.black,
                  fontFamily: 'IBMPlexSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700)),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ZeplinColors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(30, 23, 0, 23),
          children: <Widget>[
            Container(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("새로운 대여소 10곳이 추가되었어요!",
                        style: TextStyle(
                            fontFamily: 'IBMPlexSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    Text("1일전",
                        style: TextStyle(
                            color: ZeplinColors.inactivated_gray,
                            fontFamily: 'IBMPlexSans',
                            fontSize: 11,
                            fontWeight: FontWeight.w400))
                  ],
                )),
            SizedBox(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("슈룹 ver 1.0.0 이 배포되었어요!",
                        style: TextStyle(
                            fontFamily: 'IBMPlexSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    Text("30일 전",
                        style: TextStyle(
                            color: ZeplinColors.inactivated_gray,
                            fontFamily: 'IBMPlexSans',
                            fontSize: 11,
                            fontWeight: FontWeight.w400))
                  ],
                ))
          ],
        ));
  }
}
