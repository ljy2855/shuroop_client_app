import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class MainMapPage extends StatefulWidget {
  @override
  _MainMapPageState createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Completer<NaverMapController> _controller = Completer();

  List<Marker> rentalMarkers = [];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OverlayImage.fromAssetImage(
        assetName: "assets/images/rentalMarker.png",
      ).then((image) {
        setState(() {
          rentalMarkers.add(Marker(
            markerId: 'id',
            position: const LatLng(37.563600, 126.962370),
            icon: image,
            alpha: 1.0,
            flat: true,
            captionText: "5",
            captionTextSize: 13,
            captionColor: Colors.white,
            captionOffset: -27,

            anchor: AnchorPoint(0.5, 1),
            width: 30,
            height: 43,
            infoWindow: '인포 윈도우',
            //onMarkerTab: _onMarkerTap)
          ));
        });
      });
    });
    super.initState();
  }

  MapType _mapType = MapType.Basic;
  LocationTrackingMode _trackingMode = LocationTrackingMode.NoFollow;
  @override
  Widget build(BuildContext context) {
    print(rentalMarkers);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          NaverMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.563600, 126.962370),
              zoom: 17,
            ),
            onMapCreated: onMapCreated,
            mapType: _mapType,
            initLocationTrackingMode: _trackingMode,
            locationButtonEnable: true,
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
            logoClickEnabled: true,
            markers: rentalMarkers,
          ),
        ],
      ),
    );
  }

  _onMapTap(LatLng position) async {
    await (await _controller.future).moveCamera(
        CameraUpdate.toCameraPosition(CameraPosition(target: position)),
        animationDuration: 1500);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text('[onTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapLongTap(LatLng position) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onLongTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapDoubleTap(LatLng position) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onDoubleTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onMapTwoFingerTap(LatLng position) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onTwoFingerTap] lat: ${position.latitude}, lon: ${position.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  _onSymbolTap(LatLng? position, String? caption) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          '[onSymbolTap] caption: $caption, lat: ${position?.latitude}, lon: ${position?.longitude}'),
      duration: Duration(milliseconds: 500),
      backgroundColor: Colors.black,
    ));
  }

  /// 지도 생성 완료시
  void onMapCreated(NaverMapController controller) {
    if (_controller.isCompleted) _controller = Completer();
    _controller.complete(controller);
  }

  /// my location button
  // void _onTapLocation() async {
  //   final controller = await _controller.future;
  //   controller.setLocationTrackingMode(LocationTrackingMode.Follow);
  // }

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
