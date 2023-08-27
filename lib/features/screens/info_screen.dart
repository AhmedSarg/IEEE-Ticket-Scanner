import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_state.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';
import '../../core/utils/app_colors.dart';
import 'info_screen_2.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocBuilder<ScanCubit, ScanState>(builder: (context, state) {
      if (state is LoadingState) {
        print("loading");
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.transparent,
              strokeWidth: 1,
            ),
          ),
        );
      } else if (state is SuccessState) {
        print("success");
        final AttendeeModel attendee =
            BlocProvider.of<ScanCubit>(context).attendeeModel;
        var names = attendee.name.split(" ");
        var name = "${names[0]} ${names[names.length - 1]}";
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.darkGrey,
              image: DecorationImage(
                  image: AssetImage("assets/images/bg.jpg"), fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: RotationTransition(
                        turns: const AlwaysStoppedAnimation(-8 / 360),
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          // color: AppColors.darkPrimary,
                          height: 60,
                          width: w,
                          child: Text(
                            name,
                            style: const TextStyle(
                                fontFamily: "Badaboom",
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: AppColors.white,
                                letterSpacing: 5,
                                shadows: [
                                  Shadow(
                                      offset: Offset(-6.0, 0.0),
                                      blurRadius: 0.0,
                                      color: AppColors.black),
                                  Shadow(
                                      offset: Offset(-3.0, 0.0),
                                      blurRadius: 0.0,
                                      color: AppColors.red),
                                ]),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.1,
                  ),
                  SizedBox(
                    height: h * 0.4,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          detailCard("full name", attendee.name),
                          detailCard("email", attendee.email),
                          detailCard("phone", attendee.phone),
                          detailCard("age", attendee.age),
                          detailCard("city", attendee.city),
                          detailCard("university", attendee.university),
                          detailCard("college", attendee.college),
                          detailCard("academic year", attendee.academicYear),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      } else if (state is FailedState) {
        print("failed");
        return Scaffold(
          body: Center(
            child: Text(
              BlocProvider.of<ScanCubit>(context).error,
              style: const TextStyle(
                  color: AppColors.error,
                  fontFamily: "Rubik",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        print("initial");
        return const Scaffold(
          body: Center(
            child: Text(
              "Go Scan a ticket yasta",
              style: TextStyle(
                  color: AppColors.error,
                  fontFamily: "Rubik",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    });
  }
}
