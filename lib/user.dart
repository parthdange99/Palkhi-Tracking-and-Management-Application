class User {
  final String fullName;
  final String email;
  final String mobile;
  final String gender;
  final String address;
  final String pincode;

  User({
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.gender,
    required this.address,
    required this.pincode,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      gender: json['gender'] ?? '',
      address: json['address'] ?? '',
      pincode: json['pincode'] ?? '',
    );
  }
}
