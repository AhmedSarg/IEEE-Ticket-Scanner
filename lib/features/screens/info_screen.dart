import 'package:flutter/material.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key, required this.attendeeModel});
  final AttendeeModel? attendeeModel;
  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    final AttendeeModel attendee = widget.attendeeModel!;
    return Scaffold(
      body: Container(
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