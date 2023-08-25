// import 'package:flutter/material.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:ieee_ticket_scanner/features/screens/dashboard_screen.dart';
// import 'package:ieee_ticket_scanner/features/screens/scanner_screen.dart';
// import '../../core/utils/app_colors.dart';
//
// late TabController tabController;
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen>
//     with SingleTickerProviderStateMixin {
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 3, vsync: this, initialIndex: 1);
//   }
//
//   var pages = [
//     const SizedBox(),
//     Scanner(),
//     const Dashboard(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       initialIndex: 1,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.primary,
//           title: const Text(
//             'IEEE Ticket Scanner',
//             style: TextStyle(fontFamily: "Rubik"),
//           ),
//         ),
//         body: TabBarView(
//           controller: tabController,
//           children: pages,
//         ),
//         bottomNavigationBar: GNav(
//           selectedIndex: tabController.index,
//           backgroundColor: AppColors.primary,
//           textStyle: const TextStyle(fontFamily: "Rubik", color: AppColors.white, fontSize: 17),
//           color: AppColors.white,
//           activeColor: AppColors.white,
//           rippleColor: AppColors.white,
//           haptic: true,
//           gap: 5,
//           tabs: const [
//             GButton(
//               icon: Icons.info_outline,
//               text: 'Information',
//             ),
//             GButton(
//               icon: Icons.qr_code,
//               text: 'Add',
//             ),
//             GButton(
//               icon: Icons.analytics,
//               text: 'Analysis',
//             ),
//           ],
//           onTabChange: (index) {
//             setState(() {
//               tabController.index = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }
