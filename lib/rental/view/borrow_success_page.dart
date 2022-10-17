import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RentalSuccessPage extends StatelessWidget {
  const RentalSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime timeReturn = now.add(const Duration(days: 1));

    DateFormat dateFormat =
        DateFormat("24시간 후, MM월 dd일 a hh시mm분까지", Platform.localeName);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: const Text(
          "대여 완료",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: const EdgeInsets.fromLTRB(30, 30, 0, 0),
              child: const Text("우산을 대여했어요!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ))),
          const Padding(padding: EdgeInsets.only(top: 30)),
          Container(
              margin: const EdgeInsets.fromLTRB(120, 20, 120, 20),
              color: Colors.transparent,
              child: const Image(
                image: AssetImage('assets/images/umbrella.png'),
              )),
          const Padding(padding: EdgeInsets.only(top: 30)),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 0, 0, 10),
            child: const Icon(Icons.access_time_outlined),
          ),
          Container(
            //현재 시간 + 결재시간 계산
            margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),

            child: Text(dateFormat.format(timeReturn),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          Container(
            //현재 시간 + 결재시간 계산

            margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),

            child: const Text('반납하는 것을 잊지 마세요.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ),
          const Padding(padding: EdgeInsets.only(top: 8)),
          Container(
            //현재 시간 + 결재시간 계산
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 10),

            child: const Text(
              '대여 시간 초과 시 추가요금이 발생해요. 걱정마세요, 30분 전에 미리 알려드릴게요. 반납 시에도 대여소의 QR인식을 통해 반납할 수 있어요.',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF878787),
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(30, 130, 30, 40),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(350, 50),
                backgroundColor: const Color(0xFFFCB93F),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text('확인')),
      ),
    );
  }
}
