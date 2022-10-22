import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuroop_client_app/auth/provider/profile_provider.dart';
import 'package:shuroop_client_app/auth/provider/token.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:shuroop_client_app/map/model/place.dart';
import 'package:shuroop_client_app/map/view/search_fail.dart';
import 'package:shuroop_client_app/map/view/search_success.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController textController = TextEditingController();
  late ProfileProvider profile;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
    profile = Provider.of<ProfileProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
          ),
          title: TextField(
            controller: textController,
            onSubmitted: (text) async {
              if (text != '') {
                await searchPlacesWithKeyword(text).then((places) => places
                        .isEmpty
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) =>
                            SearchedFailPage(keyword: textController.text))))
                    : Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: ((context) => SearchedMapPage(
                              keyword: textController.text,
                              places: places,
                            )),
                      ))
                        .then((_) {
                        setState(() {});
                      }));
              }
            },
            decoration: const InputDecoration(
                hintText: '장소, 주소 검색',
                hintStyle: TextStyle(
                  color: ZeplinColors.base_icon_gray,
                  fontFamily: 'IBMPlexSans',
                ),
                border: InputBorder.none),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                if (textController.text != '') {
                  await searchPlacesWithKeyword(textController.text).then(
                      (places) => places.isEmpty
                          ? Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => SearchedFailPage(
                                  keyword: textController.text))))
                          : Navigator.of(context)
                              .push(MaterialPageRoute(
                              builder: ((context) => SearchedMapPage(
                                    keyword: textController.text,
                                    places: places,
                                  )),
                            ))
                              .then((_) {
                              setState(() {});
                            }));
                }
              },
              icon: const Icon(Icons.search),
              color: Colors.black,
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 40,
                  width: 180,
                  child: TabBar(
                    tabs: const [
                      Text('최근검색'),
                      Text('즐겨찾기'),
                    ],
                    controller: _tabController,
                    indicatorColor: ZeplinColors.base_yellow,
                    indicatorSize: TabBarIndicatorSize.label,
                    labelPadding: const EdgeInsets.only(bottom: 0.0),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(controller: _tabController, children: [
                  FutureBuilder(
                      future:
                          getToken().then((token) => getSearchPlaces(token)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          final List<PlaceRecord>? places = snapshot.data;
                          return Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: places!
                                  .map((place) => SizedBox(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: Text(place.place!.name!),
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .push(MaterialPageRoute(
                                                        builder: ((context) =>
                                                            SearchedMapPage(
                                                              isSelected: true,
                                                              keyword: place
                                                                  .place!.name!,
                                                              places: [
                                                                place.place!
                                                              ],
                                                            ))))
                                                    .then((_) {
                                                  setState(() {});
                                                }),
                                              ),
                                              Text(
                                                "  ${place.place!.umbrellaCount}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ZeplinColors.base_yellow,
                                                ),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () => getToken()
                                                .then((token) =>
                                                    removePlaceRecord(
                                                        place.place!.id!,
                                                        token!,
                                                        PlaceRecordType.search))
                                                .then((_) {
                                              setState(() {});
                                            }),
                                            child: const Icon(
                                              Icons.close,
                                              color:
                                                  ZeplinColors.base_icon_gray,
                                            ),
                                          ),
                                        ],
                                      )))
                                  .toList(),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                  FutureBuilder(
                      future:
                          getToken().then((token) => getFavoritePlaces(token)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          final List<PlaceRecord>? places = snapshot.data;

                          return Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: places!
                                  .map((place) => SizedBox(
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GestureDetector(
                                                child: Text(place.place!.name!),
                                                onTap: () => Navigator.of(
                                                        context)
                                                    .push(MaterialPageRoute(
                                                        builder: ((context) =>
                                                            SearchedMapPage(
                                                              isSelected: true,
                                                              keyword: place
                                                                  .place!.name!,
                                                              places: [
                                                                place.place!
                                                              ],
                                                            ))))
                                                    .then((_) {
                                                  setState(() {});
                                                }),
                                              ),
                                              Text(
                                                "  ${place.place!.umbrellaCount}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ZeplinColors.base_yellow,
                                                ),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () => getToken()
                                                .then((token) =>
                                                    removePlaceRecord(
                                                        place.place!.id!,
                                                        token!,
                                                        PlaceRecordType
                                                            .favorite))
                                                .then((_) {
                                              setState(() {});
                                            }),
                                            child: const Icon(
                                              Icons.close,
                                              color:
                                                  ZeplinColors.base_icon_gray,
                                            ),
                                          ),
                                        ],
                                      )))
                                  .toList(),
                            ),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ]),
              )
            ],
          ),
        ));
  }
}
