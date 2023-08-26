import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit() : super(LoadingAnalyticsState());

  Map<String, int> days = {
    "day-1": 0,
    "day-2": 0,
    "day-3": 0,
    "day-4": 0,
    "day-5": 0,
  };

  Map<String, double> colleges = {};

  void fetchData(List<QueryDocumentSnapshot<Object?>> docs) async {
    emit(LoadingAnalyticsState());
    late Map<String, double> thisColleges = {};
    // colleges.clear();
    days.forEach((key, value) {
      days[key] = 0;
    });
    try {
      for (var doc in docs) {
        var day1 = await doc.get("day-1");
        var day2 = await doc.get("day-2");
        var day3 = await doc.get("day-3");
        var day4 = await doc.get("day-4");
        var day5 = await doc.get("day-5");
        if (day1) {
          days["day-1"] = days["day-1"]! + 1;
          if (DateTime.now().day == 27) {
            var college = await doc.get("college");
            if (thisColleges.containsKey(college)) {
              thisColleges[college] = thisColleges[college]! + 1;
            } else {
              thisColleges[college] = 1;
            }
          }
        }
        if (day2) {
          days["day-2"] = days["day-2"]! + 1;
          if (DateTime.now().day == 4) {
            var college = await doc.get("college");
            if (colleges.containsKey(college)) {
              colleges[college] = colleges[college]! + 1;
            } else {
              colleges[college] = 1;
            }
          }
        }
        if (day3) {
          days["day-3"] = days["day-3"]! + 1;
          if (DateTime.now().day == 5) {
            var college = await doc.get("college");
            if (colleges.containsKey(college)) {
              colleges[college] = colleges[college]! + 1;
            } else {
              colleges[college] = 1;
            }
          }
        }
        if (day4) {
          days["day-4"] = days["day-4"]! + 1;
          if (DateTime.now().day == 6) {
            var college = await doc.get("college");
            if (colleges.containsKey(college)) {
              colleges[college] = colleges[college]! + 1;
            } else {
              colleges[college] = 1;
            }
          }
        }
        if (day5) {
          days["day-5"] = days["day-5"]! + 1;
          if (DateTime.now().day == 7) {
            var college = await doc.get("college");
            if (colleges.containsKey(college)) {
              colleges[college] = colleges[college]! + 1;
            } else {
              colleges[college] = 1;
            }
          }
        }
      }
      colleges = thisColleges;
      emit(SuccessAnalyticsState());
    }
    catch (e) {
      emit(FailedAnalyticsState());
    }
  }

  Stream<QuerySnapshot> getUsers() {
    return FirebaseFirestore.instance
        .collection('ScannedAttendees')
        .snapshots();
  }
}
