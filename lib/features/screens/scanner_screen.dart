import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_cubit.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';
import 'package:ieee_ticket_scanner/features/screens/main_screen.dart';
import '../../core/services/attendee_service.dart';

class Scanner extends StatelessWidget {
  Scanner({super.key});

  final AttendeeService attendeeService = AttendeeService();

  late final AttendeeModel scannedAttendee;

  Future scanBarcode(context) async {
    String barcodeScanResult = "";

    barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    try {
      BlocProvider.of<ScanCubit>(context).getUser(context, barcodeScanResult);
    } on SocketException catch (_) {
      print("No Internet Connection");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedButton(
        onPress: () async {
          try {
            final result = await InternetAddress.lookup('example.com');
            await scanBarcode(context);
            tabController.index = 0;
          } on SocketException catch (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text("No Internet Connection"),
                ),
              ),
            );
          }
        },
        transitionType: TransitionType.LEFT_BOTTOM_ROUNDER,
        text: 'Scan Ticket',
        textStyle: const TextStyle(
            fontFamily: "Rubik",
            fontSize: 18,
            color: AppColors.white,
            fontWeight: FontWeight.w600),
        backgroundColor: AppColors.primary,
        selectedBackgroundColor: AppColors.white,
        selectedTextColor: AppColors.primary,
        width: 160,
        height: 50,
        borderRadius: 20,
        borderWidth: 2,
        borderColor: AppColors.black,
        animatedOn: AnimatedOn.onHover,
      ),
    );
  }
}
