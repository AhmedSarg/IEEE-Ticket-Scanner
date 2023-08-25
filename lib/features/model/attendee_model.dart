class AttendeeModel {
  final int id;
  final String attendeeCode;
  final String name;
  final String email;
  final int phone;
  final int age;
  final String city;
  final String university;
  final String college;
  final String academicYear;
  final String question1;
  final String question2;
  final String question3;
  final String expects;
  final String comments;
  final int paymentStatus;
  final String season;
  final String time;

  AttendeeModel({
    required this.id,
    required this.attendeeCode,
    required this.name,
    required this.email,
    required this.phone,
    required this.age,
    required this.city,
    required this.university,
    required this.college,
    required this.academicYear,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.expects,
    required this.comments,
    required this.paymentStatus,
    required this.season,
    required this.time,
  });

  factory AttendeeModel.fromJson(Map jsonData) {
    return AttendeeModel(
      id: jsonData["id"],
      attendeeCode: jsonData["attendee_code"],
      name: jsonData["name"],
      email: jsonData["email"],
      phone: jsonData["phone"],
      age: jsonData["age"],
      city: jsonData["city"],
      university: jsonData["university"],
      college: jsonData["college"],
      academicYear: jsonData["acadimic_year"],
      question1: jsonData["question1"],
      question2: jsonData["question2"],
      question3: jsonData["question3"],
      expects: jsonData["expects"],
      comments: jsonData["comments"],
      paymentStatus: jsonData["payment_status"],
      season: jsonData["season"],
      time: jsonData["time"],
    );
  }
}
