import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_cubit.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_state.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';
import '../../core/bloc/details_cubit/details_cubit.dart';
import '../../core/bloc/details_cubit/details_state.dart';
import '../../core/utils/app_colors.dart';

class InfoScreen2 extends StatefulWidget {
  final String attendeeCode;

  const InfoScreen2({super.key, required this.attendeeCode});

  @override
  State<InfoScreen2> createState() => _InfoScreen2State();
}

class _InfoScreen2State extends State<InfoScreen2> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<DetailsCubit>(context)
        .getUser(context, widget.attendeeCode);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          "IEEE Ticket Scanner",
          style: TextStyle(fontFamily: "Rubik"),
        ),
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(builder: (context, state) {
        if (state is SuccessDetailsState) {
          print("success");
          final AttendeeModel attendee =
              BlocProvider.of<DetailsCubit>(context).attendeeModel;
          return SizedBox(
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
          );
        } else if (state is FailedDetailsState) {
          print("failed");
          return Center(
            child: Text(
              BlocProvider.of<ScanCubit>(context).error,
              style: const TextStyle(
                  color: AppColors.error,
                  fontFamily: "Rubik",
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          );
        } else {
          print("loading");
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.transparent,
              strokeWidth: 1,
            ),
          );
        }
      }),
    );
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
