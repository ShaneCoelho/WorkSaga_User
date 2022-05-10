import 'dart:convert';

class LoginModel {
  final String email;
  final String password;
  

  const LoginModel({required this.password, required this.email});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      password : json['password'],
    );
  }
}