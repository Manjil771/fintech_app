class PassengerDetailModel {
  String firstname;
  String lastname;
  PassengerType type;
  String title;
  String gender;

  PassengerDetailModel({
    required this.firstname,
    required this.lastname,
    required this.type,
    required this.title,
    required this.gender,
  });
}

enum PassengerType {
  adult,
  child,
  infant,
}
