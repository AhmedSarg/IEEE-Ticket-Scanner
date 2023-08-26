import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/features/screens/dashboard_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/info_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/scanner_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}
late TabController tabController;

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    tabController.addListener(_handleTabChange);
  }

  // @override
  // void dispose() {
  //   tabController.removeListener(_handleTabChange);
  //   tabController.dispose();
  //   super.dispose();
  // }

  void _handleTabChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          title: const Text(
            "IEEE Ticket Scanner",
            style: TextStyle(fontFamily: "Rubik"),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: AppColors.primary,
          child: ConvexAppBar(
            controller: tabController,
            backgroundColor: AppColors.primary,
            items: const [
              TabItem(icon: Icons.info_outline, title: "Information", fontFamily: "Rubik"),
              TabItem(icon: Icons.qr_code, title: "Scan", fontFamily: "Rubik"),
              TabItem(icon: Icons.analytics, title: "Analytics", fontFamily: "Rubik"),
            ],
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: [
            const InfoScreen(),
            Scanner(),
            const Dashboard(),
          ],
        ),
      ),
    );
  }
}
