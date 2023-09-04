import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ieee_ticket_scanner/core/bloc/analytics_cubit/analytics_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/analytics_cubit/analytics_state.dart';
import 'package:ieee_ticket_scanner/core/routes/routes.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/features/screens/history_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/main_screen.dart';
import 'package:supercharged/supercharged.dart';

const List<Color> pieChartColors = <Color>[
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
  Color(0xff18fa9b),
  Color(0xff91a6c7),
  Color(0xff0062ff),
  Color(0xffebabff),
  Color(0xffff9e7a),
  Color(0xff47153c),
  Color(0xffff338f),
  Color(0xff472215),
  Color(0xff5cff8d),
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
    print("builded");
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StreamBuilder(
                stream: BlocProvider.of<AnalyticsCubit>(context).getUsers(),
                builder: (context, snapshot) {
                  print("in stream");
                  if (snapshot.hasData) {
                    print("has data");
                    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
                        builder: (context, state) {
                          print("in bloc builder");
                      BlocProvider.of<AnalyticsCubit>(context)
                          .fetchData(snapshot.data!.docs);
                      colleges =
                          BlocProvider.of<AnalyticsCubit>(context).colleges;
                      Map<String, int> days =
                          BlocProvider.of<AnalyticsCubit>(context).days;
                      List<int> values = [
                        157,
                        days["day-2"]!,
                        days["day-3"]!,
                        days["day-4"]!,
                        days["day-5"]!
                      ];
                      s = colleges.isEmpty ? 1 : sum(colleges);
                      if (state is SuccessAnalyticsState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: double.infinity,
                              height: 250,
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
                                      touchCallback: (FlTouchEvent event,
                                          pieTouchResponse) {
                                        setState(() {
                                          if (!event
                                                  .isInterestedForInteractions ||
                                              pieTouchResponse == null ||
                                              pieTouchResponse.touchedSection ==
                                                  null) {
                                            touchedIndex = -1;
                                            return;
                                          }
                                          touchedIndex = pieTouchResponse
                                              .touchedSection!
                                              .touchedSectionIndex;
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
                              margin: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              width: double.infinity,
                              height: 220,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(35),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: LineChart(mainData(values)),
                              ),
                            ),
                          ],
                        );
                      } else if (state is FailedAnalyticsState) {
                        return const SizedBox(
                          width: double.infinity,
                          height: 540,
                          child: Center(
                            child: Text("Connection Error"),
                          ),
                        );
                      } else {
                        return const SizedBox(
                          width: double.infinity,
                          height: 540,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primary,
                              backgroundColor: AppColors.transparent,
                              strokeWidth: 1,
                            ),
                          ),
                        );
                      }
                    });
                  } else if (snapshot.hasError) {
                    print("has error");
                    return const Center(
                      child: Text("Connection Error"),
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
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
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
      ),
    );
  }

  var oneIsTouched = false;

  List<PieChartSectionData> showingSections() {
    if (colleges.isEmpty) {
      colleges = {"No Data Yet": 1};
    }
    return List.generate(colleges.length, (index) {
      final isTouched = index == touchedIndex;
      if (isTouched) {
        oneIsTouched = true;
      }
      if (touchedIndex == -1) {
        oneIsTouched = false;
      }
      const fontSize = 16.0;
      final radius = isTouched ? 120.0 : 100.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: pieChartColors[index],
        value: colleges[colleges.keys.elementAt(index)],
        title: isTouched
            ? colleges.keys.elementAt(index).toString()
            : "${(colleges[colleges.keys.elementAt(index)]! / s * 100).round()}%",
        showTitle: (oneIsTouched && !isTouched) ? false : true,
        radius: radius,
        titleStyle: const TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          shadows: shadows,
        ),
      );
    });
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.normal, fontSize: 13, color: AppColors.white);
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('DAY-1', style: style);
        break;
      case 2:
        text = const Text('DAY-2', style: style);
        break;
      case 3:
        text = const Text('DAY-3', style: style);
        break;
      case 4:
        text = const Text('DAY-4', style: style);
        break;
      case 5:
        text = const Text('DAY-5', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 15,
      color: AppColors.white,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 50:
        text = '50';
        break;
      case 100:
        text = '100';
        break;
      case 150:
        text = '150';
        break;
      case 200:
        text = '200';
        break;
      case 250:
        text = '';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<Color> gradientColors = [
    AppColors.white,
    AppColors.contentColorBlue,
  ];

  List<LineTooltipItem> getNumbers(List<LineBarSpot> values) {
    List<LineTooltipItem> ret = [];
    values.forEach((element) {
      ret.add(
        LineTooltipItem(
          element.y.ceil().toString(),
          const TextStyle(
            fontFamily: "Rubik",
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
      );
    });
    return ret;
  }

  LineChartData mainData(List<int> values) {
    print(values);
    return LineChartData(
      lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: AppColors.darkPrimary,
            tooltipRoundedRadius: 50,
            getTooltipItems: getNumbers,
          )),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: AppColors.white, width: 1),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 250,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 0),
            FlSpot(1, values[0].toDouble()),
            FlSpot(2, values[1].toDouble()),
            FlSpot(3, values[2].toDouble()),
            FlSpot(4, values[3].toDouble()),
            FlSpot(5, values[4].toDouble()),
            const FlSpot(6, 0),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
