import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shuroop_client_app/auth/provider/token.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shuroop_client_app/url.dart';

//Notification 은 flutter에 이미 있음
class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String>? notification = [];
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
            body: FutureBuilder<List<String>>(
                future: getNotifitions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    notification = snapshot.data;
                    return ListView.builder(
                        itemCount: notification?.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              margin: const EdgeInsets.fromLTRB(30, 23, 30, 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 16,
                                          height: 16,
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 3, 10, 0),
                                          child: Image.asset(
                                              "assets/images/logo_line.png"),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                width: 300,
                                                child: Text(
                                                    '${notification![index]}',
                                                    style: const TextStyle(
                                                        color:
                                                            ZeplinColors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                            Text('${datesAndTimes[1]}',
                                                style: const TextStyle(
                                                    color: ZeplinColors
                                                        .inactivated_gray,
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ));
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }
}

Future<List<String>> getNotifitions() async {
  String? token;
  await getToken().then((value) => token = value);
  List<String> notifications = [];
  try {
    final response = await http.get(
      Uri.parse('${UrlPrefix.urls}notices/get/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: 'Token $token'
      },
    );
    if (response.statusCode == 200) {
      final dataset = json.decode(utf8.decode(response.bodyBytes));
      for (Map<String, dynamic> data in dataset) {
        notifications.add(data['content']);
      }
    }
  } catch (e) {}

  return notifications;
}
