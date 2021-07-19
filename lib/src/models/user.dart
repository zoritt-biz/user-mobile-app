class User {
  final String id;
  final String firebaseId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String userType;
  final String image;
  final List<String> businesses;

  User({
    this.id,
    this.firebaseId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.userType,
    this.businesses,
    this.image,
    this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firebaseId: json['firebaseId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      userType: json['userType'],
      image: json['image'],
      businesses: (json['businesses'] as List) != null
          ? (json['businesses'] as List).length > 0
              ? (json['businesses'] as List)
                  .map((e) => e['_id'].toString())
                  .toList()
              : []
          : [],
    );
  }
}
