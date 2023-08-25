import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_state.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';
import '../../core/utils/app_colors.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanCubit, ScanState>(builder: (context, state) {
      if (state is LoadingState) {
        print("loading");
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.transparent,
              strokeWidth: 1,
            ),
          ),
        );
      } else if (state is SuccessState) {
        print("success");
        final AttendeeModel attendee = BlocProvider.of<ScanCubit>(context).attendeeModel;
        return Scaffold(
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Text("name : ${attendee.name}"),
                Text("email : ${attendee.email}"),
                Text("phone : ${attendee.phone}"),
                Text("age : ${attendee.age}"),
                Text("city : ${attendee.city}"),
                Text("university : ${attendee.university}"),
                Text("college : ${attendee.college}"),
                Text("academic year : ${attendee.academicYear}"),
              ],
            ),
          ),
        );
      } else if (state is FailedState) {
        print("failed");
        return Scaffold(
          body: Center(
            child: Text(
              BlocProvider.of<ScanCubit>(context).error,
              style: const TextStyle(
                  color: AppColors.error,
                  fontFamily: "Rubik",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        print("initial");
        return const Scaffold(
          body: Center(
            child: Text(
              "Go Scan a ticket yasta",
              style: TextStyle(
                  color: AppColors.error,
                  fontFamily: "Rubik",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      }
    });
  }
}

// Widget ticketCardText() {
//   if (ticketId == '-1') {
//     return const Text("Attendee Not Found",
//         style: TextStyle(
//             color: AppColors.white, fontSize: 24, fontFamily: "Rubik"));
//   } else if (ticketId == '') {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: const [
//         Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Text("Waiting...",
//               style: TextStyle(
//                   color: AppColors.white, fontSize: 24, fontFamily: "Rubik")),
//         ),
//         Padding(
//           padding: EdgeInsets.all(15.0),
//           child: CircularProgressIndicator(
//             color: AppColors.white,
//           ),
//         )
//       ],
//     );
//   } else if (ticketId == "nodata") {
//     return const Center(
//         child: Text("Begin scanning to show data",
//             style: TextStyle(
//                 color: AppColors.white, fontSize: 24, fontFamily: "Rubik")));
//   } else {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             "Name : ${scannedAttendee.name}",
//             style: const TextStyle(
//                 color: AppColors.white, fontSize: 16, fontFamily: "Rubik"),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             "University : ${scannedAttendee.college}",
//             style: const TextStyle(
//                 color: AppColors.white, fontSize: 16, fontFamily: "Rubik"),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             "Ticket ID : ${scannedAttendee.ticketId}",
//             style: const TextStyle(
//                 color: AppColors.white, fontSize: 16, fontFamily: "Rubik"),
//           ),
//         ),
//         const Center(
//           child: Padding(
//             padding: EdgeInsets.all(12.0),
//             child: Text(
//               "Attendee Exists",
//               style: TextStyle(
//                   color: AppColors.white, fontSize: 24, fontFamily: "Rubik"),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
