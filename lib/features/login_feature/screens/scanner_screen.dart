import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String tickedId = "";

  Future scanBarcode() async {
    String barcodeScanResult;

    barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    print(barcodeScanResult);

    setState(() {
      tickedId = barcodeScanResult;
      print("ticket ID : " + tickedId);
    });
  }

  Widget ticketCard() {
    if (tickedId == '-1') {
      return const Text("Attendant Not Found",
          style: TextStyle(
              color: AppColors.white, fontSize: 24, fontFamily: "Rubik"));
    } else if (tickedId == '') {
      return const Text("Waiting...",
          style: TextStyle(
              color: AppColors.white, fontSize: 24, fontFamily: "Rubik"));
    } else {
      return const Text("Attendant Exists",
          style: TextStyle(
              color: AppColors.white, fontSize: 24, fontFamily: "Rubik"));
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData screen = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: (screen.size.height) / 4 * 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: scanBarcode,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, elevation: 5),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Scan Ticket",
                    style: TextStyle(fontFamily: "Rubik", fontSize: 18),
                  ),
                ),
              ),
              Text(
                tickedId + " (test only)",
                style: const TextStyle(fontFamily: "Rubik", fontSize: 14),
              )
            ],
          ),
        ),
        Container(
          color: AppColors.primary,
          height: (screen.size.height) / 4,
          width: double.infinity,
          child: Center(child: ticketCard()),
        ),
      ],
    );
  }
}
