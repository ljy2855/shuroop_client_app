import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shuroop_client_app/auth/provider/profile_provider.dart';
import 'package:shuroop_client_app/auth/view/login.dart';
import 'package:shuroop_client_app/map/model/place.dart';
import 'package:shuroop_client_app/rental/view/deposit_info.dart';
import 'package:shuroop_client_app/rental/view/scanner.dart';
import '../../rental/view/deposit_info.dart';

class MainMapPage extends StatefulWidget {
  @override
  _MainMapPageState createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();

  List<Marker> rentalMarkers = [];

  late ProfileProvider profile;

  @override
  void initState() {
    super.initState();
  }

  final MapType _mapType = MapType.Basic;
  LocationTrackingMode _trackingMode = LocationTrackingMode.Follow;
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting(Localizations.localeOf(context).languageCode);
    profile = Provider.of<ProfileProvider>(context, listen: true);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: SizedBox(
            height: kToolbarHeight * 0.7,
            child: Image.asset("assets/images/logo.png")),
        centerTitle: true,
        toolbarHeight: kToolbarHeight,
      ),
      body: FutureBuilder<List<Place>>(
          future: getPlaceDataAPI(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final List<Place>? places = snapshot.data;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                OverlayImage.fromAssetImage(
                  assetName: "assets/images/rentalMarker.png",
                  devicePixelRatio: 4.0,
                ).then((image) {
                  rentalMarkers.addAll(places!
                      .map<Marker>((place) => getRentalMarker(image, place))
                      .toList());
                });
              });
              return Stack(
                children: <Widget>[
                  NaverMap(
                    initialCameraPosition: const CameraPosition(
                      target: LatLng(37.5513, 126.9414),
                      zoom: 17,
                    ),
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
                    markers: rentalMarkers,
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
    return SizedBox(
      height: 150,
      width: double.infinity,
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 70,
              width: double.infinity,
            ),
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
                      MaterialButton(
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
                              )
                            }
                          else
                            {
                              if (profile.getLeftTime() == Duration.zero)
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          const DepositInformation())))
                                }
                              else
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: ((context) =>
                                          const QRScanPage())))
                                }
                            }
                        },
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          profile.getProfile() == null ||
                                  profile.getIsRenting() == false
                              ? '우산 대여하기'
                              : '우산 반납하기',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Marker getRentalMarker(OverlayImage image, Place place) => Marker(
        markerId: place.id.toString(),
        position: place.position,
        icon: image,
        alpha: 1.0,
        flat: true,
        captionText: place.umbrellaCount.toString(),
        captionTextSize: 13,
        captionColor: Colors.white,
        captionOffset: -27,
        anchor: AnchorPoint(0.5, 1),
        width: 30,
        height: 43,
        infoWindow: '${place.name} 지점\n남은 개수: ${place.umbrellaCount}',
      );

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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onLongTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: const Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
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
    print('카메라 움직임 >>> 위치 : ${latLng?.latitude}, ${latLng?.longitude}'
        '\n원인: $reason'
        '\n에니메이션 여부: $isAnimated');
  }

  void _onCameraIdle() {
    print('카메라 움직임 멈춤');
  }
}
