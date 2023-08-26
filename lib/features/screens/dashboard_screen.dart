import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/analytics_cubit/analytics_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/analytics_cubit/analytics_state.dart';
import 'dart:math' as math;
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/features/screens/history_screen.dart';

const List<MaterialColor> pieChartColors = <MaterialColor>[
  Colors.indigo,
  Colors.orange,
  Colors.green,
  Colors.cyan,
  Colors.red,
  Colors.pink,
  Colors.deepPurple,
  Colors.brown,
  Colors.deepOrange,
  Colors.blueGrey,
  Colors.purple,
  Colors.blue,
  Colors.lightBlue,
  Colors.teal,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
];

double sum(Map<String, double> map) {
  double s = 0;
  map.forEach((key, value) {
    s += value;
  });
  return s;
}


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int touchedIndex = -1;
  var i = 0;
  late double s;
  late Map<String, double> colleges;
  @override
  Widget build(BuildContext context) {
    s = sum(colleges);
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder(
            stream: BlocProvider.of<AnalyticsCubit>(context).getUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return BlocBuilder(
                  builder: (context, state) {
                    BlocProvider.of<AnalyticsCubit>(context).fetchData(snapshot.data!.docs);
                    colleges = BlocProvider.of<AnalyticsCubit>(context).colleges;
                    if (state is SuccessAnalyticsState) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 40),
                        height: 200,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              width: 240,
                              height: 150,
                              decoration: const BoxDecoration(
                                  color: AppColors.nearlyWhite,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(35),
                                  )),
                              child: PieChart(
                                PieChartData(
                                    pieTouchData: PieTouchData(
                                      touchCallback:
                                          (FlTouchEvent event, pieTouchResponse) {
                                        setState(() {
                                          if (!event.isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection == null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!.touchedSectionIndex;
                                        });
                                      },
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    centerSpaceRadius: 0,
                                    sections: showingSections()),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                width: 240,
                                height: 150,
                                decoration: const BoxDecoration(
                                    color: Color(0x07000000),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(35),
                                    ))),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              width: 240,
                              height: 150,
                              decoration: const BoxDecoration(
                                color: Color(0x07000000),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(35),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    else if (state is FailedAnalyticsState) {
                      return const Center(child: Text("Connection Error"),);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          backgroundColor: AppColors.transparent,
                          strokeWidth: 1,
                        ),
                      );
                    }
                  }
                );
              }
              else if (snapshot.hasError) {
                return const Center(child: Text("Connection Error"),);
              }
              else {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                    backgroundColor: AppColors.transparent,
                    strokeWidth: 1,
                  ),
                );
              }
            }
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Show All Attendees",
                  style: TextStyle(fontFamily: 'Rubik', fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  var oneIsTouched = false;

  List<PieChartSectionData> showingSections() {
    return List.generate(colleges.length, (index) {
      final isTouched = index == touchedIndex;
      if (isTouched) {
        oneIsTouched = true;
      }
      if (touchedIndex == -1) {
        oneIsTouched = false;
      }
      final fontSize = isTouched ? 12.0 : 16.0;
      final radius = isTouched ? 100.0 : 80.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: pieChartColors[index],
        value: colleges[colleges.keys.elementAt(index)],
        title: isTouched
            ? colleges.keys.elementAt(index).toString()
            : "${(colleges[colleges.keys.elementAt(index)]! / s * 100).round()}%",
        showTitle: (oneIsTouched && !isTouched) ? false : true,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          shadows: shadows,
        ),
      );
    });
  }
}
