import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidable/hidable.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_state.dart';
import 'package:ieee_ticket_scanner/features/screens/dashboard_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/info_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/scanner_screen.dart';

import '../../core/utils/app_colors.dart';
import 'data_screen.dart';

const _kPages = <String, IconData>{
  'Info': FontAwesomeIcons.info,
  'Add': Icons.qr_code,
  'Analysis': Icons.analytics
};

final ScrollController scrollController = ScrollController();
late TabController tabController;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    print("builded");
    return BlocBuilder<ScanCubit, ScanState>(
        builder: (context, state) {
          Widget getDataPage() {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  backgroundColor: AppColors.transparent,
                  strokeWidth: 1,
                ),
              );
            } else if (state is SuccessState) {
              return InfoScreen(
                  attendeeModel:
                      BlocProvider.of<ScanCubit>(context).attendeeModel);
            } else if (state is FailedState) {
              return const DataScreen();
            } else {
              return const DataScreen();
            }
          }

          var pages = [
            getDataPage(),
            // SizedBox(),
            Scanner(),
            const Dashboard(),
          ];

          return DefaultTabController(
            length: 3,
            initialIndex: 1,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AppColors.primary,
                title: const Text(
                  'IEEE Ticket Scanner',
                  style: TextStyle(fontFamily: "Rubik"),
                ),
              ),
              body: pages[BlocProvider.of<ScanCubit>(context).index],
              bottomNavigationBar: Hidable(
                controller: scrollController,
                child: ConvexAppBar(
                  disableDefaultTabController: true,
                  style: TabStyle.reactCircle,
                  height: 100,
                  backgroundColor: AppColors.primary,
                  initialActiveIndex: BlocProvider.of<ScanCubit>(context).index,
                  onTap: (i) {
                    setState(() {
                      BlocProvider.of<ScanCubit>(context).index = i;
                    });
                    print(BlocProvider.of<ScanCubit>(context).index);
                  },
                  items: [
                    for (final entry in _kPages.entries)
                      TabItem(
                        icon: entry.value,
                        title: entry.key,
                      )
                  ],
                ),
                // child: ConvexAppBar(
                //   height: 100,
                //   style: TabStyle.reactCircle,
                //   backgroundColor: AppColors.primary,
                //   items: <TabItem>[
                //     for (final entry in _kPages.entries)
                //       TabItem(
                //         icon: entry.value,
                //         title: entry.key,
                //         fontFamily: "Rubik",
                //       ),
                //   ],
                // ),
              ),
            ),
          );
        });

    // return BlocBuilder<ScanCubit, ScanState>(
    //   builder: (context, state) {
    //     if (state is LoadingState) {
    //       print("loading");
    //       return DefaultTabController(
    //         length: 3,
    //         initialIndex: 0,
    //         child: Scaffold(
    //           appBar: AppBar(
    //             backgroundColor: AppColors.primary,
    //             title: const Text(
    //               'IEEE Ticket Scanner',
    //               style: TextStyle(fontFamily: "Rubik"),
    //             ),
    //           ),
    //           body: Column(
    //             children: [
    //               Expanded(
    //                 child: TabBarView(
    //                   children: [
    //                     const Center(
    //                       child: CircularProgressIndicator(
    //                         color: AppColors.primary,
    //                         backgroundColor: AppColors.transparent,
    //                         strokeWidth: 1,
    //                       ),
    //                     ),
    //                     Scanner(),
    //                     const Dashboard(),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           bottomNavigationBar: Hidable(
    //             controller: scrollController,
    //             // child: ConvexAppBar(
    //             //   height: 100,
    //             //   style: TabStyle.reactCircle,
    //             //   backgroundColor: AppColors.primary,
    //             //   items: <TabItem>[
    //             //     for (final entry in _kPages.entries)
    //             //       TabItem(
    //             //         icon: entry.value,
    //             //         title: entry.key,
    //             //         fontFamily: "Rubik",
    //             //       ),
    //             //   ],
    //             //   // onTap: (int i) => print('click index=$i'),
    //             // ),
    //             child: BottomNavigationBar(
    //               onTap: (i) => tabController.index = i,
    //                 currentIndex: tabController.index,
    //                 // height: 100,
    //                 // style: TabStyle.reactCircle,
    //                 backgroundColor: AppColors.primary,
    //                 items: <BottomNavigationBarItem>[
    //                   for (final entry in _kPages.entries)
    //                     BottomNavigationBarItem(
    //                       icon: Icon(entry.value),
    //                       label: entry.key,
    //                       // fontFamily: "Rubik",
    //                     ),
    //                 ]
    //                 // onTap: (int i) => print('click index=$i'),
    //                 ),
    //           ),
    //         ),
    //       );
    //     } else if (state is SuccessState) {
    //       print("success");
    //       return DefaultTabController(
    //         length: 3,
    //         initialIndex: 0,
    //         child: Scaffold(
    //           appBar: AppBar(
    //             backgroundColor: AppColors.primary,
    //             title: const Text(
    //               'IEEE Ticket Scanner',
    //               style: TextStyle(fontFamily: "Rubik"),
    //             ),
    //           ),
    //           body: Column(
    //             children: [
    //               Expanded(
    //                 child: TabBarView(
    //                   children: [
    //                     InfoScreen(
    //                         attendeeModel: BlocProvider.of<ScanCubit>(context)
    //                             .attendeeModel),
    //                     Scanner(),
    //                     const Dashboard(),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           bottomNavigationBar: Hidable(
    //             controller: scrollController,
    //             child: BottomNavigationBar(
    //                 onTap: (i) => tabController.index = i,
    //                 currentIndex: tabController.index,
    //                 // height: 100,
    //                 // style: TabStyle.reactCircle,
    //                 backgroundColor: AppColors.primary,
    //                 items: <BottomNavigationBarItem>[
    //                   for (final entry in _kPages.entries)
    //                     BottomNavigationBarItem(
    //                       icon: Icon(entry.value),
    //                       label: entry.key,
    //                       // fontFamily: "Rubik",
    //                     ),
    //                 ]
    //                 // onTap: (int i) => print('click index=$i'),
    //                 ),
    //           ),
    //         ),
    //       );
    //     } else if (state is FailedState) {
    //       print("failed");
    //       return DefaultTabController(
    //         length: 3,
    //         initialIndex: 0,
    //         child: Scaffold(
    //           appBar: AppBar(
    //             backgroundColor: AppColors.primary,
    //             title: const Text(
    //               'IEEE Ticket Scanner',
    //               style: TextStyle(fontFamily: "Rubik"),
    //             ),
    //           ),
    //           body: Column(
    //             children: [
    //               Expanded(
    //                 child: TabBarView(
    //                   children: [
    //                     const DataScreen(),
    //                     Scanner(),
    //                     const Dashboard(),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           bottomNavigationBar: Hidable(
    //             controller: scrollController,
    //             child: BottomNavigationBar(
    //                 currentIndex: tabController.index,
    //                 onTap: (i) => tabController.index = i,
    //                 // height: 100,
    //                 // style: TabStyle.reactCircle,
    //                 backgroundColor: AppColors.primary,
    //                 items: <BottomNavigationBarItem>[
    //                   for (final entry in _kPages.entries)
    //                     BottomNavigationBarItem(
    //                       icon: Icon(entry.value),
    //                       label: entry.key,
    //                       // fontFamily: "Rubik",
    //                     ),
    //                 ]
    //                 // onTap: (int i) => print('click index=$i'),
    //                 ),
    //             // child: ConvexAppBar(
    //             //   height: 100,
    //             //   style: TabStyle.reactCircle,
    //             //   backgroundColor: AppColors.primary,
    //             //   items: <TabItem>[
    //             //     for (final entry in _kPages.entries)
    //             //       TabItem(
    //             //         icon: entry.value,
    //             //         title: entry.key,
    //             //         fontFamily: "Rubik",
    //             //       ),
    //             //   ],
    //             //   // onTap: (int i) => print('click index=$i'),
    //             // ),
    //           ),
    //         ),
    //       );
    //     } else {
    //       print("initial");
    //       return DefaultTabController(
    //         length: 3,
    //         initialIndex: 0,
    //         child: Scaffold(
    //           appBar: AppBar(
    //             backgroundColor: AppColors.primary,
    //             title: const Text(
    //               'IEEE Ticket Scanner',
    //               style: TextStyle(fontFamily: "Rubik"),
    //             ),
    //           ),
    //           body: Column(
    //             children: [
    //               Expanded(
    //                 child: TabBarView(
    //                   children: [
    //                     const DataScreen(),
    //                     Scanner(),
    //                     const Dashboard(),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //           bottomNavigationBar: Hidable(
    //             controller: scrollController,
    //             child: BottomNavigationBar(
    //                 // height: 100,
    //                 // style: TabStyle.reactCircle,
    //                 onTap: (i) => tabController.index = i,
    //               currentIndex: 1,
    //                 backgroundColor: AppColors.primary,
    //                 items: <BottomNavigationBarItem>[
    //                   for (final entry in _kPages.entries)
    //                     BottomNavigationBarItem(
    //                       icon: Icon(entry.value),
    //                       label: entry.key,
    //                       // fontFamily: "Rubik",
    //                     ),
    //                 ]
    //                 // onTap: (int i) => print('click index=$i'),
    //                 ),
    //             // child: ConvexAppBar(
    //             //   height: 100,
    //             //   style: TabStyle.reactCircle,
    //             //   backgroundColor: AppColors.primary,
    //             //   items: <TabItem>[
    //             //     for (final entry in _kPages.entries)
    //             //       TabItem(
    //             //         icon: entry.value,
    //             //         title: entry.key,
    //             //         fontFamily: "Rubik",
    //             //       ),
    //             //   ],
    //             //   // onTap: (int i) => print('click index=$i'),
    //             // ),
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );
  }
}
