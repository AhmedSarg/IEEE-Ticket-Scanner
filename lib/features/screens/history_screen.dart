import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';

import '../../core/bloc/scan_cubit/scan_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("details builded");
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendees Details"),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: AppColors.primary,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: BlocProvider.of<ScanCubit>(context).getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var attendees = snapshot.data!.docs;
              return AnimationLimiter(
                child: ListView.builder(
                  padding: EdgeInsets.all(_w / 30),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: attendees.length,
                  itemBuilder: (BuildContext c, int i) {
                    var attendee = attendees[i];
                    return AnimationConfiguration.staggeredList(
                      position: i,
                      delay: const Duration(milliseconds: 150),
                      child: SlideAnimation(
                        duration: const Duration(milliseconds: 2500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        horizontalOffset: 30,
                        verticalOffset: 300.0,
                        child: FlipAnimation(
                          duration: const Duration(milliseconds: 3000),
                          curve: Curves.fastLinearToSlowEaseIn,
                          flipAxis: FlipAxis.y,
                          child: Container(
                            margin: EdgeInsets.only(bottom: _w / 20),
                            // height: _w / 4,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 40,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(15),
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  attendee.get("name"),
                                  style: const TextStyle(fontFamily: "Rubik", fontSize: 18),
                                ),
                              ),
                              subtitle: Text(
                                attendee.get("college") +
                                    " " +
                                    attendee.get("university"),
                                style: const TextStyle(fontFamily: "Rubik", fontSize: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Connection Error",
                  style: TextStyle(
                      color: AppColors.error,
                      fontFamily: "Rubik",
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.transparent,
                  strokeWidth: 1,
                ),
              );
            }
          }),
    );
  }
}
