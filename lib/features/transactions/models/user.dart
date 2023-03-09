class User {
  final String firstname;
  final String lastname;
  final String userId;

  User({required this.firstname, required this.lastname, required this.userId});

  User.fromMap(Map<String, dynamic> map)
      : firstname = map['firstname'],
        lastname = map['lastname'],
        userId = map['userId'];

  Map<String, dynamic> toMap() {
    return {
      'userFirstname': firstname,
      'userLastname': lastname,
      'userId': userId,
    };
  }
}
