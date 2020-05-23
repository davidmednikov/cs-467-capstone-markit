class MarkitUserModel {
  int id;
  String firstName;
  String lastName;
  String username;
  String password;
  int userReputation; // need type
  String userLevel; // need type
  DateTime reputationLastUpdated;
  DateTime createdDate;
  DateTime updatedDate;

  MarkitUserModel({this.id, this.firstName, this.lastName, this.username, this.password, this.userReputation, this.userLevel, this.reputationLastUpdated});

  factory MarkitUserModel.fromJsonForPriceCheck(Map<String, dynamic> json) {
    return MarkitUserModel(
      username: json['userName'],
      userReputation: json['userReputation'],
      userLevel: json['userLevel'],
    );
  }
}