import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/analytics_cubit/analytics_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/details_cubit/details_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_cubit.dart';
import 'package:ieee_ticket_scanner/features/screens/loading_screen.dart';
import 'package:ieee_ticket_scanner/features/screens/main_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart' show Firebase;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ScanCubit()),
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => AnalyticsCubit()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
        // home: LoadingScreen(),
      ),
    );
  }
}
