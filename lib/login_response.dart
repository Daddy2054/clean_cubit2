import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final String? accessToken;
  final int? userId;
  final String? name;
  final String? email;

  const LoginResponse({
    this.accessToken,
    this.userId,
    this.name,
    this.email,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        accessToken: data['access_token'] as String?,
        userId: data['user_id'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'access_token': accessToken,
        'user_id': userId,
        'name': name,
        'email': email,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  LoginResponse copyWith({
    String? accessToken,
    int? userId,
    String? name,
    String? email,
  }) {
    return LoginResponse(
      accessToken: accessToken ?? this.accessToken,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [accessToken, userId, name, email];
}
