import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:shuroop_client_app/map/model/place.dart';

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
    );
  }
}
