import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shuroop_client_app/auth/provider/profile_provider.dart';
import 'package:shuroop_client_app/auth/provider/token.dart';
import 'package:shuroop_client_app/colors.dart';
import 'package:shuroop_client_app/rental/model/record.dart';
import 'package:shuroop_client_app/rental/view/return_completed.dart';
import 'package:shuroop_client_app/rental/view/borrow_success_page.dart';
import 'package:shuroop_client_app/url.dart';
import 'package:http/http.dart' as http;

enum QRScanType {
  borw,
  retrn,
}

class QRScanPage extends StatefulWidget {
  final QRScanType type;
  const QRScanPage({Key? key, required this.type}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Barcode? result;
  QRViewController? controller;
  Record? record;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void initState() {
    super.initState();
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: widget.type == QRScanType.borw
              ? ZeplinColors.base_yellow
              : ZeplinColors.return_theme_color,
          centerTitle: true,
          title: widget.type == QRScanType.borw
              ? const Text("대여하기")
              : const Text("반납하기"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white60,
          onPressed: () async {
            await controller?.toggleFlash(); //toggleFlash()
          },
          child: const Icon(Icons.flash_on)),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 10,
              child: Stack(
                children: [
                  _buildQrView(context),
                  ValueListenableBuilder(
                      valueListenable: isLoading,
                      builder: ((context, value, child) => Center(
                          child: value
                              ? const CircularProgressIndicator()
                              : Container())))
                ],
              )),
          //To check qr data
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double scanArea = width * 0.65;

    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.orange,
              borderRadius: 0,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        PositionedDirectional(
          bottom: (height + scanArea) / 2,
          start: (width - scanArea) / 2,
          end: (width - scanArea) / 2,
          child: const Text("대여함의 QR코드를 찍어 주세요",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: "LeferiBaseType",
                  fontStyle: FontStyle.normal,
                  fontSize: 16),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      reassemble();
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });
      isLoading.value = true;
      await controller.pauseCamera();
      if (await checkQRcode(scanData)) {
        if (!mounted) return;

        if (await rentalRequest(scanData.code!)) {
          await Future.delayed(const Duration(milliseconds: 500));
          if (widget.type == QRScanType.borw) {
            await Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const RentalSuccessPage()));
          } else {
            await Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ReturnCompleted(
                      record: record!,
                    )));
          }
        }
      } else {
        await controller.pauseCamera();
        await Future.delayed(const Duration(milliseconds: 500));
        if (!mounted) return;
        await controller.resumeCamera();
      }
      isLoading.value = false;
    });
  }

  Future<bool> checkQRcode(Barcode barcode) async {
    const errorSnackBar = SnackBar(
      duration: Duration(milliseconds: 500),
      content: Text('유효하지 않은 QR코드입니다.\n다시 인식해주세요.'),
    );

    if (barcode.code!.contains(UrlPrefix.urls) && barcode.code != null) {
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
      return false;
    }
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  Future<bool> rentalRequest(String url) async {
    String? token;
    await getToken().then((value) {
      token = value;
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: 'Token $token'
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes));
        final profile = Provider.of<ProfileProvider>(context, listen: false);
        profile.setProfile(token!);
        if (widget.type == QRScanType.retrn) {
          record = Record.fromJson(data);
        }
        return true;
      }
    } catch (e) {}
    return false;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
