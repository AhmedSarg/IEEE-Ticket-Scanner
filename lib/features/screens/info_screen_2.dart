import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_cubit.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';
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
  fontSize: 22,
  color: AppColors.white,
  shadows: [
    Shadow(offset: Offset(-5.0, 0.0), blurRadius: 10.0, color: AppColors.black),
  ],
);

TextStyle detailStyle = const TextStyle(
    fontFamily: "Rubik",
    fontSize: 17,
    color: AppColors.white,
    shadows: [
      Shadow(
          offset: Offset(-5.0, 0.0), blurRadius: 10.0, color: AppColors.black),
    ],
    fontWeight: FontWeight.w600);

class _InfoScreen2State extends State<InfoScreen2> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    BlocProvider.of<DetailsCubit>(context)
        .getUser(context, widget.attendeeCode);
    return Scaffold(
      body: BlocBuilder<DetailsCubit, DetailsState>(builder: (context, state) {
        if (state is SuccessDetailsState) {
          print("success");
          final AttendeeModel attendee =
              BlocProvider.of<DetailsCubit>(context).attendeeModel;
          var names = attendee.name.split(" ");
          var name = "${names[0]} ${names.length - 1 > 0 ? names[names.length - 1] : ""}";
          return Container(
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
                    height: h * 0.13,
                  ),
                  SizedBox(
                    height: h * 0.5,
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
                          detailCard(
                              "academic year", attendee.academicYear),
                        ],
                      ),
                    ),
                  )
                ],
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
        child: const Icon(
          Icons.arrow_back,
          color: AppColors.primary,
        ),
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
              "$title :  ",
              style: titleStyle,
            ),
            Expanded(
              child: Text(
                detail.toString(),
                style: detailStyle,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
