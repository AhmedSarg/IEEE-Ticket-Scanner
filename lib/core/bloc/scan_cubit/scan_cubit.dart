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

  void addUser(AttendeeModel attendeeModel) {
    CollectionReference users =
    FirebaseFirestore.instance.collection('ScannedAttendees');
    users
        .add(
      {
        "id": attendeeModel.id,
        "attendeeCode": attendeeModel.attendeeCode,
        "name": attendeeModel.name,
        "university": attendeeModel.university,
        "college": attendeeModel.college
      },
    )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<QuerySnapshot> getUsers() {
    return FirebaseFirestore.instance
        .collection('ScannedAttendees')
        .snapshots();
  }

  void getUser(context, String attendeeCode) async {
    emit(LoadingState());
    try {
      attendeeModel = await attendeeService.getUser(context, attendeeCode);
      signed = await attendeeService.signUserToday(attendeeModel.id.toString());
      if (signed) {
        addUser(attendeeModel);
        emit(SuccessState());
      } else {
        error = "ticket has been used today";
        emit(FailedState());
      }
    } catch (e) {
      error = "ticket not found";
      emit(FailedState());
    }
  }
}