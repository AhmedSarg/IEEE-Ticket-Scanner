import 'package:dio/dio.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';

class AttendeeService {
  String baseUrl = "https://dummyjson.com/users";
  late AttendeeModel attendeeModel;
  late List<dynamic> result;

  Future<AttendeeModel> getUser({required String ticket}) async {
    final dio = Dio();
    await dio.get(baseUrl).then((value) {
      value.data.forEach((user) {
        if (user["ip"] == ticket /*and not in firebase list*/) {}
      });
    });
    return AttendeeModel(name: "ahmed", college: "banha", ticketId: "9090");
  }
}
