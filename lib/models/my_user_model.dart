import 'dart:convert';

class MyUser {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String token;

  MyUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.address,
      required this.type,
      required this.token});

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map["_id"] ?? '',
      name: map["name"] ?? '',
      email: map["email"] ?? '',
      password: map["password"] ?? '',
      address: map["address"] ?? '',
      type: map["type"] ?? '',
      token: map["token"] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "password": password,
      "address": address,
      "type": type,
      "token": token,
    };
  }

  String toJson() => json.encode(toMap());
  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source));
}
