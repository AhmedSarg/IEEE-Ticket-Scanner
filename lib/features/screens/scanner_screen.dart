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

  AttendeeService attendeeService = AttendeeService();
  late AttendeeModel scannedAttendee;

  Future scanBarcode(context) async {
    String barcodeScanResult = "";

    barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ffffff", "Cancel", true, ScanMode.QR);
    try {
      BlocProvider.of<ScanCubit>(context).getUser(context, barcodeScanResult);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: AnimatedButton(
        onPress: () async {
          await scanBarcode(context);
          tabController.index = 0;
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
