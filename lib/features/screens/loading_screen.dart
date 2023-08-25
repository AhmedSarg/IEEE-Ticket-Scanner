// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:ieee_ticket_scanner/core/services/check_internet.dart';
// import 'package:ieee_ticket_scanner/features/screens/main_screen.dart';
//
// class LoadingScreen extends StatefulWidget {
//   const LoadingScreen({super.key});
//
//   @override
//   State<LoadingScreen> createState() => _LoadingScreenState();
// }
//
// class _LoadingScreenState extends State<LoadingScreen> {
//   Map _source = {ConnectivityResult.none: false};
//   final NetworkConnectivity _networkConnectivity = NetworkConnectivity.instance;
//   String string = 'Checking Internet Connection...';
//   @override
//   void initState() {
//     super.initState();
//     _networkConnectivity.initialise();
//     _networkConnectivity.myStream.listen((source) {
//       _source = source;
//       if (_source.keys.toList()[0] == ConnectivityResult.mobile ||
//           _source.keys.toList()[0] == ConnectivityResult.wifi) {
//         if (_source.values.toList()[0]) {
//           string = 'Connected';
//           Timer(const Duration(seconds: 3), (() {
//             Navigator.of(context).pushReplacement(
//                 MaterialPageRoute(builder: (context) => const MainScreen()));
//           }));
//         } else {
//           string = 'Network Error';
//         }
//       } else {
//         string = 'Network Error';
//       }
//
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primary,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Image.asset(
//               'assets/images/ieee_logo.png',
//               height: 150,
//             ),
//             const CircularProgressIndicator(
//               color: AppColors.white,
//               backgroundColor: AppColors.transparent,
//               strokeWidth: 1,
//             ),
//             Text(
//               string,
//               style:
//                   const TextStyle(color: AppColors.white, fontFamily: "Rubik"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _networkConnectivity.disposeStream();
//     super.dispose();
//   }
// }
