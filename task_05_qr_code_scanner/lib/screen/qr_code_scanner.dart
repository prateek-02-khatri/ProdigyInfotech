import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task_05_qr_code_scanner/Utils.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  String qrResult = 'Scanned Data will appear here';

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      setState(() {
        qrResult = qrCode != '-1' ? qrCode : 'Failed to scan QR Code';
      });
    } on PlatformException {
      qrResult = 'Failed to read QR Code';
    }
  }

  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;

    if (status.isDenied || status.isPermanentlyDenied) {
      if (await Permission.camera.request().isGranted) {
        print("Camera Permission granted..!!");
      } else {
        print('Camera Permission Denied..!!');
        return;
      }
    } else if (status.isRestricted) {
      print('Camera Permission is restricted..!!');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Utils.customAppBar(title: 'QR Code Scanner'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              qrResult,
              style: Utils.customTextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Utils.customElevatedButton(
                onPressed: () {
                  scanQR();
                },
                text: 'Scan QR'),
          ],
        ),
      ),
      backgroundColor: Utils.bgColor,
    );
  }
}
