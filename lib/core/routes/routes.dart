import 'package:flutter/cupertino.dart';
import 'package:ieee_ticket_scanner/features/screens/history_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/main_screen.dart';

var myRoutes = <String, WidgetBuilder>{
  '/': (BuildContext context) => const MainScreen(),
  '/history': (BuildContext context) => const HistoryScreen(),
};