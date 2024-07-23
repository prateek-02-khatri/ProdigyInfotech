import 'package:flutter/material.dart';
import 'package:task_05_qr_code_scanner/Utils.dart';
import 'package:task_05_qr_code_scanner/screen/qr_code_generator.dart';
import 'package:task_05_qr_code_scanner/screen/qr_code_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: Utils.customAppBar(title: 'QR Code Scanner'),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Utils.customElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const QrCodeScanner()));
                },
                text: 'Scan QR Code'
            ),

            const SizedBox(height: 50),

            Utils.customElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const QrCodeGenerator()));
              },
              text: 'Generate QR Code'
            )
          ],
        ),
      ),

      backgroundColor: Utils.bgColor,
    );
  }
}
