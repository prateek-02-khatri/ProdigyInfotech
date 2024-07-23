import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:task_05_qr_code_scanner/Utils.dart';

class QrCodeGenerator extends StatefulWidget {
  const QrCodeGenerator({super.key});

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: Utils.customAppBar(title: 'QR Code Generator'),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              urlController.text.isNotEmpty
                ?
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: QrImageView(
                  data: urlController.text,
                  size: 250
                ),
              )
                :
              Text(
                "Generate QR Code",
                style: Utils.customTextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    hintText: "Enter your link here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    labelText: "Enter your data",
                    labelStyle: Utils.customTextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    )
                  ),
                  style: Utils.customTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),

              const SizedBox(height: 50),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Utils.customElevatedButton(
                  onPressed: () {
                    setState(() {});
                  },
                  text: "Generate QR Code",
                ),
              ),
            ],
          ),
        ),
      ),

      backgroundColor: Utils.bgColor,
    );
  }
}
