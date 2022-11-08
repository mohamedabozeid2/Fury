class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? uId;

  UserModel({
    required this.lastName,
    required this.firstName,
    required this.uId,
    required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    uId = json['uId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'uId': uId,
      'firstName': firstName,
      'lastName': lastName,
    };
  }
}
