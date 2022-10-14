import 'package:flutter/material.dart';

import 'package:shuroop_client_app/colors.dart';

class SearchedFailPage extends StatelessWidget {
  final String keyword;
  const SearchedFailPage({
    super.key,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: TextField(
          decoration: InputDecoration(
              enabled: false,
              hintText: keyword,
              hintStyle: const TextStyle(
                fontFamily: 'IBMPlexSans',
                color: Colors.black,
              ),
              border: InputBorder.none),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Icon(
              Icons.warning_rounded,
              size: 30,
              color: ZeplinColors.base_icon_gray,
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "검색 결과가 존재하지 않습니다.",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            Text(
              "다른 검색어로 대여소를 검색해보세요.",
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 12,
                color: ZeplinColors.base_icon_gray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
