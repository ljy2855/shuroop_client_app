import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:shuroop_client_app/map/model/place.dart';

class SearchedMapPage extends StatefulWidget {
  final List<Place> places;
  final String keyword;
  const SearchedMapPage({
    super.key,
    required this.places,
    required this.keyword,
  });

  @override
  State<SearchedMapPage> createState() => _SearchedMapPageState();
}

class _SearchedMapPageState extends State<SearchedMapPage> {
  late LatLng middlePosition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    middlePosition = getMiddlePostion();
  }

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
              hintText: widget.keyword,
              hintStyle: const TextStyle(
                fontFamily: 'IBMPlexSans',
                color: Colors.black,
              ),
              border: InputBorder.none),
        ),
      ),
      body: Column(
        children: [
          Stack(children: [
            SizedBox(
              height: 500,
              child: FutureBuilder(
                  future: Future(() => getMarkerWithImage(widget.places)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      final List<Marker>? markers = snapshot.data;
                      return NaverMap(
                        initialCameraPosition:
                            CameraPosition(target: middlePosition),
                        markers: markers!,
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ]),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 25),
              scrollDirection: Axis.vertical,
              child: Column(
                children: widget.places
                    .map((place) => SizedBox(
                          width: 400,
                          child: Container(
                            padding: EdgeInsets.only(left: 20, top: 25),
                            child: Row(
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            place.name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16),
                                          ),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10)),
                                          Text(
                                            "${place.umbrellaCount}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: ZeplinColors.base_yellow,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        place.address!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300,
                                          color: ZeplinColors.base_icon_gray,
                                        ),
                                      ),
                                    ]),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                      Icons.keyboard_arrow_right_rounded),
                                  color: ZeplinColors.base_yellow,
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  LatLng getMiddlePostion() {
    double lat = 0;
    double lon = 0;
    for (Place place in widget.places) {
      lat += place.position!.latitude;
      lon += place.position!.longitude;
    }
    lat /= widget.places.length;
    lon /= widget.places.length;

    return LatLng(lat, lon);
  }
}
