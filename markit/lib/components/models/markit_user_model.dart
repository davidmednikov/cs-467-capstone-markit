class MarkitUserModel {
  int id;
  String firstName;
  String lastName;
  String username;
  String password;
  int reputation; // need type
  String level; // need type
  DateTime reputationLastUpdated;
  DateTime createdDate;
  DateTime updatedDate;

  MarkitUserModel({this.id, this.firstName, this.lastName, this.username, this.password, this.reputation, this.level, this.reputationLastUpdated});

  factory MarkitUserModel.fromJsonForProfile(Map<String, dynamic> json) {
    return MarkitUserModel(
      id: json['id'],
      username: json['userName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      reputation: json['reputation'],
      level: json['level'],
    );
  }

  factory MarkitUserModel.fromJsonForPriceCheck(Map<String, dynamic> json) {
    return MarkitUserModel(
      id: json['id'],
      username: json['userName'],
      reputation: json['userReputation'],
      level: json['userLevel'],
    );
  }

  factory MarkitUserModel.fromJsonForLiveFeed(Map<String, dynamic> json) {
    return MarkitUserModel(
      id: json['id'],
      username: json['userName'],
      reputation: json['reputation'],
      level: json['level'],
    );
  }
}