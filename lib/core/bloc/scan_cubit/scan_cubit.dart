import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ieee_ticket_scanner/core/bloc/scan_cubit/scan_state.dart';
import '../../../features/model/attendee_model.dart';
import '../../services/attendee_service.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(InitialState());
  AttendeeService attendeeService = AttendeeService();
  late AttendeeModel attendeeModel;
  late bool signed;
  int index = 1;
  String error = "";

  // List<Map<String, dynamic>> users = [];

  void addUser(AttendeeModel attendeeModel) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('ScannedAttendees');
    users
        .add(
          {
            "id": attendeeModel.id,
            "name": attendeeModel.name,
            "university": attendeeModel.university,
            "college": attendeeModel.college
          },
        )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    List<Map<String, dynamic>> users = [];
    await FirebaseFirestore.instance
        .collection('ScannedAttendees')
        .snapshots()
        .listen((snapshot) {
      snapshot.docs.forEach((doc) {
        print(doc.data());
        users.add(doc.data());
      });
    });
    return users;
  }

  void getUser(context, String attendeeCode) async {
    emit(LoadingState());
    try {
      attendeeModel = await attendeeService.getUser(context, attendeeCode);
      addUser(attendeeModel);
      emit(SuccessState());
    } catch (e) {
      error = "ticket not found";
      emit(FailedState());
    }
  }

  void signUserToday(String attendeeId) async {
    emit(LoadingState());
    try {
      signed = await attendeeService.signUserToday(attendeeId);
      emit(SuccessState());
    } catch (e) {
      emit(FailedState());
    }
  }
}
