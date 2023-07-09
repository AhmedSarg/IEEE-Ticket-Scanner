import 'package:flutter/material.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/core/utils/app_values.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                        ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
