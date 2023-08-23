import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hidable/hidable.dart';
import 'package:ieee_ticket_scanner/features/screens/dashboard_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/scanner_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../core/utils/app_colors.dart';

const _kPages = <String, IconData>{
  'Info': FontAwesomeIcons.info,
  'Add': Icons.qr_code,
  'Analysis': Icons.analytics
};
final ScrollController scrollController = ScrollController();

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
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
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  const Scanner(),
                  const Dashboard(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Hidable(
          controller: scrollController,
          child: ConvexAppBar(
            height: 100,
            style: TabStyle.reactCircle,
            backgroundColor: AppColors.primary,
            items: <TabItem>[
              for (final entry in _kPages.entries)
                TabItem(
                  icon: entry.value,
                  title: entry.key,
                  fontFamily: "Rubik",
                ),
            ],
            // onTap: (int i) => print('click index=$i'),
          ),
        ),
      ),
    );
  }
}
