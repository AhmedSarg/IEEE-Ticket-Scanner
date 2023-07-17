import 'package:dio/dio.dart';
import 'package:ieee_ticket_scanner/features/model/attendee_model.dart';

class AttendeeService {
  String baseUrl = "https://dummyjson.com/users";
  late AttendeeModel attendeeModel;
  late List<dynamic> result;

  Future<AttendeeModel> getUser({required String ticket}) async {
    final dio = Dio();
    await dio.get(baseUrl).then((value) {
      result = value.data["users"];
    });
    for (final user in result) {
      if (user["ip"] == ticket /*and not in firebase list*/) {
        attendeeModel = AttendeeModel.fromJson(user);
        return attendeeModel;
      }
    }
    throw Exception();
  }
}
