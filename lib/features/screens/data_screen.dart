import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/bloc/scan_cubit/scan_cubit.dart';
import '../../core/utils/app_colors.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          BlocProvider.of<ScanCubit>(context).error,
          style: const TextStyle(
            color: AppColors.error,
            fontFamily: "Rubik",
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
