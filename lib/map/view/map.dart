import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shuroop_client_app/auth/provider/profile_provider.dart';
import 'package:shuroop_client_app/auth/provider/token.dart';
import 'package:shuroop_client_app/auth/view/login.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:shuroop_client_app/map/model/place.dart';
import 'package:shuroop_client_app/map/view/search.dart';
import 'package:shuroop_client_app/mypage/personal_info.dart';
import 'package:shuroop_client_app/notification/view/notification.dart';
import 'package:shuroop_client_app/rental/view/deposit_info.dart';
import 'package:shuroop_client_app/rental/view/scanner.dart';
import 'package:shuroop_client_app/weather/model/weather.dart';

class MainMapPage extends StatefulWidget {
  @override
  _MainMapPageState createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();
  final ValueNotifier<bool> isWeatherWidgetOpen = ValueNotifier<bool>(true);

  List<Marker> rentalMarkers = [];
  LatLng currentPosition = const LatLng(37.5513, 126.9414);

  late ProfileProvider profile;

  @override
  void initState() {
    super.initState();
  }

  final MapType _mapType = MapType.Basic;
  final LocationTrackingMode _trackingMode = LocationTrackingMode.Follow;
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
    profile = Provider.of<ProfileProvider>(context, listen: false);
    getToken().then((token) {
      if (token != null) return profile.setProfile(token);
    });

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
            height: kToolbarHeight * 0.7,
            child: Image.asset("assets/images/logo.png")),
        centerTitle: true,
        toolbarHeight: kToolbarHeight,
        leading: IconButton(
          color: ZeplinColors.base_icon_gray,
          padding: const EdgeInsets.only(left: 12, top: 12),
          iconSize: 30,
          constraints: const BoxConstraints(maxHeight: 27),
          icon: const Icon(Icons.notifications_none_sharp),
          onPressed: () {
            if (profile.getProfile() != null) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: ((context) => const NotificationPage())));
            }
          },
        ),
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) => const SearchPage()))),
            color: ZeplinColors.base_icon_gray,
            padding: const EdgeInsets.only(right: 12, top: 12),
            iconSize: 30,
            constraints: const BoxConstraints(maxHeight: 27),
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: FutureBuilder<List<Marker>>(
          future: getPlaceDataAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final List<Marker>? markers = snapshot.data;

              return Stack(
                children: <Widget>[
                  NaverMap(
                    onMapCreated: onMapCreated,
                    mapType: _mapType,
                    initLocationTrackingMode: _trackingMode,
                    locationButtonEnable: false,
                    indoorEnable: true,
                    onCameraChange: _onCameraChange,
                    onCameraIdle: _onCameraIdle,
                    onMapTap: _onMapTap,
                    onMapLongTap: _onMapLongTap,
                    onMapDoubleTap: _onMapDoubleTap,
                    onMapTwoFingerTap: _onMapTwoFingerTap,
                    onSymbolTap: _onSymbolTap,
                    maxZoom: 17,
                    minZoom: 12,
                    useSurface: kReleaseMode,
                    markers: markers!,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 30,
                        bottom: 180,
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: _onTapLocation,
                        child: const Icon(
                          Icons.my_location,
                          size: 30,
                          color: Color(0xFFACACAC),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: bottomBar(),
                  )
                ],
              );
            } else {
              // Otherwise, display a loading indicator.
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget bottomBar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ValueListenableBuilder(
            valueListenable: isWeatherWidgetOpen,
            builder: (context, value, child) =>
                value ? weatherWiget() : Container()),
        Material(
          elevation: 10,
          child: SizedBox(
            height: 80,
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Column(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(
                    top: 10,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: isWeatherWidgetOpen,
                              builder: ((context, value, child) => IconButton(
                                  iconSize: 30,
                                  constraints:
                                      const BoxConstraints(maxHeight: 27),
                                  color: value
                                      ? ZeplinColors.base_yellow
                                      : ZeplinColors.inactivated_gray,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 0),
                                  onPressed: () {
                                    isWeatherWidgetOpen.value =
                                        !isWeatherWidgetOpen.value;
                                  },
                                  icon: const Icon(
                                    Icons.wb_sunny_outlined,
                                  )))),
                          const Text(
                            "날씨",
                            style: TextStyle(
                                color: ZeplinColors.inactivated_gray,
                                fontSize: 12),
                          )
                        ],
                      ),
                      profile.getProfile() == null ||
                              profile.getIsRenting() == false
                          ? MaterialButton(
                              minWidth: 200,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              height: 40,
                              onPressed: () => {
                                if (profile.getProfile() == null)
                                  {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginPage(),
                                      ),
                                    ).then((_) => setState(() {}))
                                  }
                                else
                                  {
                                    if (profile.getLeftTime() == Duration.zero)
                                      {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: ((context) =>
                                                    DepositInformation())))
                                            .then(
                                              (_) => setState(() {}),
                                            )
                                      }
                                    else
                                      {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: ((context) =>
                                                    const QRScanPage(
                                                      type: QRScanType.borw,
                                                    ))))
                                            .then((_) => setState(() {}))
                                      }
                                  }
                              },
                              color: Theme.of(context).primaryColor,
                              child: const Text(
                                '우산 대여하기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          : MaterialButton(
                              minWidth: 200,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              height: 40,
                              onPressed: () => {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: ((context) => const QRScanPage(
                                              type: QRScanType.retrn,
                                            ))))
                                    .then((_) {
                                  setState(() {});
                                })
                              },
                              color: ZeplinColors.return_theme_color,
                              child: const Text(
                                '우산 반납하기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      Column(
                        children: [
                          IconButton(
                              iconSize: 30,
                              constraints: const BoxConstraints(maxHeight: 27),
                              color: ZeplinColors.inactivated_gray,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 0),
                              onPressed: () {
                                if (profile.getProfile() != null) {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                          builder: ((context) =>
                                              PersonalInfo())))
                                      .then((value) {
                                    setState(() {});
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.people_alt_outlined,
                              )),
                          const Text(
                            "내정보",
                            style: TextStyle(
                                color: ZeplinColors.inactivated_gray,
                                fontSize: 12),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  weatherWiget() {
    return SizedBox(
      height: 70,
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: FutureBuilder(
            future: Future.wait([
              getPositionToAddress(currentPosition),
              getWeatherDataAPI(currentPosition)
            ]),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final address = snapshot.data?.first;
                final List<Weather> weather = snapshot.data?[1];
                return Row(
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 30)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.my_location,
                              size: 14,
                              color: ZeplinColors.inactivated_gray,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            Text(
                              address.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          checkRainny(weather.sublist(0, 8))
                              ? "오늘은 비가 올지도 몰라요"
                              : "오늘은 화창할거에요!",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: ZeplinColors.sub_text,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 110),
                    ),
                    weatherInfo(weather[0]),
                    weatherInfo(weather[3]),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  checkRainny(List<Weather> weathers) {
    for (Weather weather in weathers) {
      if (weather.status == WeatherType.rainny) {
        return true;
      }
    }
    return false;
  }

  weatherInfo(Weather weather) {
    final dateformat = DateFormat('aa', 'ko');
    return SizedBox(
      height: 50,
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          weather.status == WeatherType.rainny
              ? const Icon(
                  Icons.umbrella,
                  size: 24,
                  color: ZeplinColors.rainy_weather_icon,
                )
              : weather.status == WeatherType.sunny
                  ? const Icon(
                      Icons.wb_sunny,
                      size: 24,
                      color: ZeplinColors.base_yellow,
                    )
                  : const Icon(
                      Icons.cloud,
                      size: 24,
                      color: ZeplinColors.inactivated_gray,
                    ),
          Text(
            "${dateformat.format(weather.time!)} ${weather.temperature!.toInt()}°",
            maxLines: 1,
            style: const TextStyle(
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  _onMapTap(LatLng position) async {
    await (await _controller.future).moveCamera(
        CameraUpdate.toCameraPosition(CameraPosition(target: position)),
        animationDuration: 1500);
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content:
    //       Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
    //   duration: Duration(milliseconds: 500),
    //   backgroundColor: Colors.black,
    // ));
  }

  _onMapLongTap(LatLng position) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(
    //       '[onLongTap] lat: ${position.latitude}, lon: ${position.longitude}'),
    //   duration: const Duration(milliseconds: 500),
    //   backgroundColor: Colors.black,
    // ));
  }

  _onMapDoubleTap(LatLng position) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(
    //       '[onDoubleTap] lat: ${position.latitude}, lon: ${position.longitude}'),
    //   duration: Duration(milliseconds: 500),
    //   backgroundColor: Colors.black,
    // ));
  }

  _onMapTwoFingerTap(LatLng position) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(
    //       '[onTwoFingerTap] lat: ${position.latitude}, lon: ${position.longitude}'),
    //   duration: Duration(milliseconds: 500),
    //   backgroundColor: Colors.black,
    // ));
  }

  _onSymbolTap(LatLng? position, String? caption) {
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text(
    //       '[onSymbolTap] caption: $caption, lat: ${position?.latitude}, lon: ${position?.longitude}'),
    //   duration: Duration(milliseconds: 500),
    //   backgroundColor: Colors.black,
    // ));
  }

  /// 지도 생성 완료시
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  /// my location button
  void _onTapLocation() async {
    final controller = await _controller.future;
    controller.setLocationTrackingMode(LocationTrackingMode.Follow);
  }

  void _onCameraChange(
      LatLng? latLng, CameraChangeReason reason, bool? isAnimated) {
    currentPosition = latLng!;
    // print('카메라 움직임 >>> 위치 : ${latLng?.latitude}, ${latLng?.longitude}'
    //     '\n원인: $reason'
    //     '\n에니메이션 여부: $isAnimated');
  }

  void _onCameraIdle() {
    // print('카메라 움직임 멈춤');
  }
}
