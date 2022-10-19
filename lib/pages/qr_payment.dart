import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:quick_pay/pages/confirm_payment.dart';

class qr_payment extends StatefulWidget {
  const qr_payment({Key? key}) : super(key: key);

  @override
  State<qr_payment> createState() => _qr_paymentState();
}

class _qr_paymentState extends State<qr_payment> {
  MobileScannerController cameraController = MobileScannerController();
  bool _screenOpened = false;

  @override
  Widget build(BuildContext context) {
    var we = MediaQuery.of(context).size.width;
    var he = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
        backgroundColor: Colors.indigo.shade900,
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Please Scan the QR code here:',
              style: TextStyle(fontSize: 19),
            ),
            Container(
              height: he * 0.7,
              width: we,
              child: MobileScanner(
                allowDuplicates: true,
                controller: cameraController,
                onDetect: _foundBarcode,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _foundBarcode(Barcode barcode, MobileScannerArguments? args) {
    /// open screen
    if (!_screenOpened) {
      final String code = barcode.rawValue ?? "---";
      debugPrint('Barcode found! $code');
      _screenOpened = true;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => payment(
              screenClosed: _screenWasClosed,
              value: code,
              check: true,
            ),
          ));
    }
  }

  void _screenWasClosed() {
    _screenOpened = false;
  }
}
