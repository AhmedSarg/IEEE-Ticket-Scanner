import 'package:flutter/material.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/features/screens/scanner_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 3,
          initialIndex: 1,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primary,
              title: const Text(
                "IEEE Ticket Scanner",
                style: TextStyle(fontFamily: "Rubik"),
              ),
            ),
            bottomNavigationBar: const BottomAppBar(
              color: AppColors.primary,
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: AppColors.white,
                  indicatorWeight: 1,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.abc),
                    ),
                    Tab(
                      icon: Icon(Icons.qr_code),
                    ),
                    Tab(
                      icon: Icon(Icons.dashboard),
                    )
                  ]),
            ),
            body: const TabBarView(children: [
              Icon(Icons.abc),
              Scanner(),
              Icon(Icons.dashboard),
            ]),
          )),
    );
  }
}
