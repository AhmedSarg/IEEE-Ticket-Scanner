import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_state.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';
import 'package:im_stepper/stepper.dart';
import '../../core/bloc/details_cubit/details_cubit.dart';
import '../../core/bloc/details_cubit/details_state.dart';
import '../../core/utils/app_colors.dart';

class InfoScreen2 extends StatefulWidget {
  final String attendeeCode;

  const InfoScreen2({super.key, required this.attendeeCode});

  @override
  State<InfoScreen2> createState() => _InfoScreen2State();
}

TextStyle titleStyle = const TextStyle(
  fontFamily: "Badaboom",
  fontSize: 25,
  color: AppColors.white,
  shadows: [
    Shadow(offset: Offset(-5.0, 0.0), blurRadius: 10.0, color: AppColors.black),
  ],
);

TextStyle detailStyle = const TextStyle(
  fontFamily: "Rubik",
  fontSize: 20,
  color: AppColors.white,
  shadows: [
    Shadow(offset: Offset(-5.0, 0.0), blurRadius: 10.0, color: AppColors.black),
  ],
  fontWeight: FontWeight.w600
);

class _InfoScreen2State extends State<InfoScreen2> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailsCubit>(context)
        .getUser(context, widget.attendeeCode);
    return Scaffold(
      body: BlocBuilder<DetailsCubit, DetailsState>(builder: (context, state) {
        if (state is SuccessDetailsState) {
          print("success");
          final AttendeeModel attendee =
              BlocProvider.of<DetailsCubit>(context).attendeeModel;
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.darkGrey,
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text(
                              attendee.name,
                              style: const TextStyle(
                                  fontFamily: "Badaboom",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 60,
                                  color: AppColors.white,
                                  shadows: [
                                    Shadow(
                                        offset: Offset(-3.0, 0.0),
                                        blurRadius: 0.0,
                                        color: AppColors.red),
                                  ]),
                            ),
                          ),
                        ),
                        detailCard("email", attendee.email),
                        detailCard("phone", attendee.phone),
                        detailCard("age", attendee.age),
                        detailCard("city", attendee.city),
                        detailCard("university", attendee.university),
                        detailCard("college", attendee.college),
                        detailCard("academic year", attendee.academicYear),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else if (state is FailedDetailsState) {
          print("failed");
          return Center(
            child: Text(
              BlocProvider.of<ScanCubit>(context).error,
              style: const TextStyle(
                  color: AppColors.error,
                  fontFamily: "Rubik",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          print("loading");
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.transparent,
              strokeWidth: 1,
            ),
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: AppColors.white,
        child: const Icon(Icons.arrow_back, color: AppColors.primary,),
      ),
    );
  }
}

Widget detailCard(title, detail) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.white, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Row(
          children: [
            Text(
              "$title :   ",
              style: titleStyle,
            ),
            Expanded(
              child: Text(
                detail.toString(),
                style: detailStyle,
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
