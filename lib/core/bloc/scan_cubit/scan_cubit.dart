import 'dart:io';

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
  late bool sent;
  int index = 1;
  String error = "";

  void addUser(AttendeeModel attendeeModel) {
    FirebaseFirestore.instance
        .collection('ScannedAttendees')
        .add(
          {
            "id": attendeeModel.id,
            "attendeeCode": attendeeModel.attendeeCode,
            "name": attendeeModel.name,
            "university": attendeeModel.university,
            "college": attendeeModel.college,
          },
        )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));

    var today = DateTime.now().day;
    FirebaseFirestore.instance
        .collection('Day${today - 2}')
        .add(
          {
            "id": attendeeModel.id,
            "attendeeCode": attendeeModel.attendeeCode,
            "name": attendeeModel.name,
            "university": attendeeModel.university,
            "college": attendeeModel.college,
          },
        )
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<QuerySnapshot> getUsers() {
    var today = DateTime.now().day;
    return FirebaseFirestore.instance.collection('Day${today - 2}').snapshots();
  }

  void getUser(context, String attendeeCode) async {
    emit(LoadingState());
    try {
      attendeeModel = await attendeeService.getUser(context, attendeeCode);
      signed = await attendeeService.signUserToday(attendeeModel.id.toString());
      if (signed) {
        print("in signed");
        sent = await attendeeService.signUserDay(attendeeModel.id.toString());
        if (sent) {
          print("in sent");
          addUser(attendeeModel);
          emit(SuccessState());
        } else {
          print("in else sent");
          error = "couldn't connect to schedule api";
          emit(FailedState());
        }
      } else {
        print("in else signed");
        error = "ticket has been used today";
        emit(FailedState());
      }
    } on SocketException catch(_) {
      print("no internet connection");
    }
    catch (e) {
      error = "ticket not found";
      emit(FailedState());
    }
  }
}
