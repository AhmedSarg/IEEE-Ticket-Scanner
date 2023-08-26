import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';

import '../bloc/scan_cubit/scan_cubit.dart';
import '../database/api/dio_consumer.dart';

class AttendeeService {
  String baseUrl = "https://dummyjson.com/users";
  late AttendeeModel attendeeModel;
  late List<dynamic> result;

  Future<AttendeeModel> getUser(context, String attendeeCode) async {
    late AttendeeModel attendeeModel;
    final dio = Dio();
    var result;
    await dio.post(
        "https://ieee-bub.org/API/API/v1/event_attendee/flutter-2023/check_member",
        data: {
          "data": {"attendee_code": attendeeCode}
        }).then((value) {
      result = value.data["data"];
    });
    if (result == "False, Error Occured while return data") {
      throw Exception();
    } else {
      attendeeModel = AttendeeModel.fromJson(result[0]);
      return attendeeModel;
    }
  }

  Future<bool> signUserToday(String attendeeId) async {
    final dio = Dio();
    var result;
    await dio.post(
        "https://ieee-bub.org/API/API/v1/event_attendee/flutter-2023/attendee_schedule",
        data: {
          "data": {
            "attendee_id": attendeeId,
          }
        }).then((value) {
      result = value.data["status"];
    });
    if (result == 400) {
      return false;
    } else if (result == 201){
      return true;
    }
    else {
      throw Exception();
    }
  }
}
