import 'dart:convert';

class Users {
  String id;
  String name;

  Users({
    this.id = '',
    this.name = '',
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
    );
  }

  factory Users.fromString(String jsonString) {
    return Users.fromJson(jsonDecode(jsonString));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
