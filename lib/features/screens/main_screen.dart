import 'package:flutter/material.dart';
import 'package:ieee_ticket_scanner/core/utils/app_colors.dart';
import 'package:ieee_ticket_scanner/features/screens/dashboard_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/scanner_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    _tabController.addListener(_handleTabChange);
    tabText(1);
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  late List<Tab> tabs;

  void tabText(int ind) {
    if (ind == 0) {
      tabs = [
        const Tab(icon: Icon(Icons.abc), text: "Unknown Yet"),
        const Tab(icon: Icon(Icons.qr_code)),
        const Tab(icon: Icon(Icons.dashboard))
      ];
    } else if (ind == 1) {
      tabs = [
        const Tab(icon: Icon(Icons.abc)),
        const Tab(icon: Icon(Icons.qr_code), text: "Scan Ticket"),
        const Tab(icon: Icon(Icons.dashboard))
      ];
    } else if (ind == 2) {
      tabs = [
        const Tab(icon: Icon(Icons.abc)),
        const Tab(icon: Icon(Icons.qr_code)),
        const Tab(icon: Icon(Icons.dashboard), text: "Dashboard")
      ];
    } else {
      tabs = [
        const Tab(icon: Icon(Icons.abc)),
        const Tab(icon: Icon(Icons.qr_code)),
        const Tab(icon: Icon(Icons.dashboard))
      ];
    }
    setState(() {});
  }

  void _handleTabChange() {
    tabText(_tabController.index);
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
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: AppColors.white,
            indicatorWeight: 1,
            controller: _tabController,
            tabs: tabs,
            onTap: (value) => (tabText(_tabController.index)),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            Icon(Icons.abc),
            Scanner(),
            Dashboard(),
          ],
        ),
      ),
    );
  }
}
