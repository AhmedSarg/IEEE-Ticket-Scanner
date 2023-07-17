import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:ieee_ticket_scanner/core/services/attendee_service.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String ticketId = "";
  AttendeeService attendeeService = AttendeeService();
  late AttendeeModel scannedAttendee;

  Future scanBarcode() async {
    String barcodeScanResult = "";

    barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    try {
      scannedAttendee =
          await attendeeService.getUser(ticket: barcodeScanResult);
    } catch (e) {
      barcodeScanResult = "-1";
    }

    setState(() {
      ticketId = barcodeScanResult;
    });
  }

  Widget ticketCardText() {
    if (ticketId == '-1') {
      return const Text("Attendee Not Found",
          style: TextStyle(
              color: AppColors.white, fontSize: 24, fontFamily: "Rubik"));
    } else if (ticketId == '') {
      return const Text("Waiting...",
          style: TextStyle(
              color: AppColors.white, fontSize: 24, fontFamily: "Rubik"));
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Name : ${scannedAttendee.name}",
              style: const TextStyle(
                  color: AppColors.white, fontSize: 18, fontFamily: "Rubik"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "University : ${scannedAttendee.college}",
              style: const TextStyle(
                  color: AppColors.white, fontSize: 18, fontFamily: "Rubik"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Ticket ID : ${scannedAttendee.ticketId}",
              style: const TextStyle(
                  color: AppColors.white, fontSize: 18, fontFamily: "Rubik"),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("Attendee Exists",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontFamily: "Rubik")),
            ),
          ),
        ],
      );
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
                onPressed: () {
                  setState(() {
                    ticketId = "";
                  });
                  scanBarcode();
                },
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
                ticketId + " (test only)",
                style: const TextStyle(fontFamily: "Rubik", fontSize: 14),
              )
            ],
          ),
        ),
        Container(
          color: AppColors.primary,
          height: (screen.size.height) / 4,
          width: double.infinity,
          child: Center(child: ticketCardText()),
        ),
      ],
    );
  }
}
