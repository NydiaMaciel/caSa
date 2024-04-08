import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/users/registerQR.dart';
import 'package:demo_casa_3/screens/users/qrScannerOverlay.dart';
import 'package:demo_casa_3/screens/users/scanQR.dart';
import 'package:demo_casa_3/services/sessions.dart';
import 'package:flutter/material.dart';
//import 'dart:ui_web';
import 'dart:ui';
import 'package:getwidget/getwidget.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

String url='url';

class Scanner extends StatefulWidget {
  Moderators usuario;
  Sesion dataSesion;
  Scanner({super.key, required this.usuario, required this.dataSesion});


  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 500,
              child: Stack(
                children: [
                  MobileScanner(
                    allowDuplicates: false,
                    controller: cameraController,
                    onDetect: (barcode, args) {
                      final String? code = barcode.rawValue;
                      debugPrint('Barcode found! $code');
                      setState(() {
                        url=code.toString();
                        //Navigator.push(context,MaterialPageRoute(builder: (context) =>RegisterQR(code: url)));  
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterQR(code: url,usuario: widget.usuario,dataSesion: widget.dataSesion)));
                      //Navigator.of(context).pop();
                    }
                  ),
                  QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.7)),  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}