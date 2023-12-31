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
    "day-26": 0,
  };

  Map<String, double> colleges = {};

  void fetchData(List<QueryDocumentSnapshot<Object?>> docs) async {
    emit(LoadingAnalyticsState());
    late Map<String, double> thisColleges = {
      "others": 1,
    };

    Map<String, int> thisDays = {
      "day-1": 0,
      "day-2": 0,
      "day-3": 0,
      "day-4": 0,
      "day-5": 0,
    };
    if (DateTime.now().day >= 4) {
      getDay(2).listen((collection) {
        thisDays["day-2"] = collection.size;
        days["day-2"] = thisDays["day-2"]!;
      });
    }
    if (DateTime.now().day >= 5) {
      getDay(3).listen((collection) {
        thisDays["day-3"] = collection.size;
        days["day-3"] = thisDays["day-3"]!;
      });
    }
    if (DateTime.now().day >= 6) {
      getDay(4).listen((collection) {
        thisDays["day-4"] = collection.size;
        days["day-4"] = thisDays["day-4"]!;
      });
    }
    if (DateTime.now().day >= 7) {
      getDay(5).listen((collection) {
        thisDays["day-5"] = collection.size;
        days["day-5"] = thisDays["day-5"]!;
      });
    }

    try {
      var today = DateTime.now().day;
      getDay(today - 2).listen((collection) {
        collection.docs.forEach((doc) {
          var college = doc.get("college");
          if (thisColleges.containsKey(college)) {
            thisColleges[college] = thisColleges[college]! + 1;
          } else {
            if (thisColleges.length <= 7) {
              thisColleges[college] = 1;
            } else {
              thisColleges["others"] = thisColleges["others"]! + 1;
            }
          }
        });
        colleges = thisColleges;
        emit(SuccessAnalyticsState());
      });
      print(colleges);
      emit(SuccessAnalyticsState());
    } catch (e) {
      emit(FailedAnalyticsState());
    }
  }

  Stream<QuerySnapshot> getUsers() {
    print("in get users");
    return FirebaseFirestore.instance
        .collection('ScannedAttendees')
        .snapshots();
  }

  Stream<QuerySnapshot> getDay(int dayNumber) {
    return FirebaseFirestore.instance
        .collection('Day${dayNumber.toString()}')
        .snapshots();
  }
}
