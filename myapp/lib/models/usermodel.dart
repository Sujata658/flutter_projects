class User {
  String name;
  String email;
  String phone;
  String password;
  String cpassword;

  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.cpassword,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      cpassword: json['cpassword'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'cpassword': cpassword,
    };
  }
}
