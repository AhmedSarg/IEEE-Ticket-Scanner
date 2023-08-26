import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/model/attendee_model.dart';
import '../../services/attendee_service.dart';
import 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(LoadingDetailsState());
  AttendeeService attendeeService = AttendeeService();
  late AttendeeModel attendeeModel;
  String error = "";


  void getUser(context, String attendeeCode) async {
    emit(LoadingDetailsState());
    try {
      attendeeModel = await attendeeService.getUser(context, attendeeCode);
      emit(SuccessDetailsState());
    } catch (e) {
      error = "ticket not found";
      emit(FailedDetailsState());
    }
  }
}
