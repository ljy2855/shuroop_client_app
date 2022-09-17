import 'package:flutter/material.dart';
import 'package:shuroop_client_app/colors.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {},
          ),
          title: const TextField(
            decoration: InputDecoration(
                hintText: '장소, 주소 검색',
                hintStyle: TextStyle(
                  color: ZeplinColors.base_icon_gray,
                  fontFamily: 'IBMPlexSans',
                ),
                border: InputBorder.none),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.black,
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 40,
                  width: 180,
                  child: TabBar(
                    tabs: [
                      Container(
                        child: Text('최근검색'),
                      ),
                      Container(
                        child: Text('즐겨찾기'),
                      )
                    ],
                    controller: _tabController,
                    indicatorColor: ZeplinColors.base_yellow,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: EdgeInsets.only(bottom: 0.0),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('신촌'),
                                Icon(
                                  Icons.close,
                                  color: ZeplinColors.base_icon_gray,
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.white,
                  )
                ]),
              )
            ],
          ),
        ));
  }
}
