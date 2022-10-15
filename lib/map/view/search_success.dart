import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:shuroop_client_app/auth/provider/token.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:shuroop_client_app/map/model/place.dart';

class SearchedMapPage extends StatefulWidget {
  final List<Place> places;
  final String keyword;
  final bool? isSelected;

  const SearchedMapPage({
    super.key,
    required this.places,
    required this.keyword,
    this.isSelected,
  });

  @override
  State<SearchedMapPage> createState() => _SearchedMapPageState();
}

class _SearchedMapPageState extends State<SearchedMapPage> {
  late LatLng middlePosition;
  bool isSelected = false;
  final ValueNotifier<bool> isFavorite = ValueNotifier<bool>(false);

  late Place currentSelectedPlace;
  @override
  void initState() {
    super.initState();
    middlePosition = getMiddlePostion();
    if (widget.isSelected ?? false || widget.places.length == 1) {
      isSelected = true;
      currentSelectedPlace = widget.places.first;
    }
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
          Expanded(
            flex: 2,
            child: Stack(children: [
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: 450,
                  maxHeight: 640,
                ),
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
          ),
          isSelected == false
              ? Expanded(
                  child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 25),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: widget.places
                        .map((place) => GestureDetector(
                              onTap: () async {
                                await getToken().then(
                                  (token) =>
                                      addSearchedPlace(place.id!, token!),
                                );
                                setState(() {
                                  isSelected = true;
                                  currentSelectedPlace = place;
                                });
                              },
                              child: placeInfoComponet(place),
                            ))
                        .toList(),
                  ),
                ))
              : selectedPlaceInfoComponent(currentSelectedPlace),
        ],
      ),
    );
  }

  Widget selectedPlaceInfoComponent(Place place) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 150),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            placeInfoComponet(place),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: isFavorite,
                    builder: (context, value, child) => IconButton(
                        onPressed: () => getToken()
                                .then((token) =>
                                    addFavoritePlace(place.id!, token!))
                                .then((_) {
                              isFavorite.value = !isFavorite.value;
                            }),
                        icon: !value
                            ? const Icon(
                                Icons.star_border_rounded,
                                size: 20,
                                color: ZeplinColors.base_icon_gray,
                              )
                            : const Icon(
                                Icons.star_rounded,
                                size: 20,
                                color: ZeplinColors.base_yellow,
                              )),
                  ),
                  IconButton(
                      onPressed: (() {}),
                      icon: const Icon(
                        Icons.share_outlined,
                        size: 20,
                        color: ZeplinColors.base_icon_gray,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget placeInfoComponet(Place place) {
    return SizedBox(
      width: 400,
      child: Container(
        padding: const EdgeInsets.only(left: 30, top: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    place.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
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
              padding: const EdgeInsets.only(right: 30),
              onPressed: () {},
              icon: const Icon(Icons.keyboard_arrow_right_rounded),
              color: ZeplinColors.base_yellow,
            )
          ],
        ),
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
