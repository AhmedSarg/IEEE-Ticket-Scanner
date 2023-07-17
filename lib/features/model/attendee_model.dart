class AttendeeModel {
  final String name;
  final String college;
  final String ticketId;

  AttendeeModel(
      {required this.name, required this.college, required this.ticketId});

  factory AttendeeModel.fromJson(Map jsonData) {
    //return AttendeeModel(name: jsonData['name'], college: jsonData['college'], ticketId: jsonData['ticketId']);
    return AttendeeModel(
        name: (jsonData['firstName'] + " " + jsonData['lastName']),
        college: jsonData['university'],
        ticketId: jsonData['ip']);
  }
}
