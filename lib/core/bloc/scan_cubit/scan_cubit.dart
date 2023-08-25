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
  String error = "Go Scan a ticket yasta";

  void getUser(String attendeeCode) async {
    emit(LoadingState());
    try {
      attendeeModel = await attendeeService.getUser(attendeeCode);
      emit(SuccessState());
    }
    catch (e) {
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