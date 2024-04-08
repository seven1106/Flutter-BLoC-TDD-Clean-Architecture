import 'package:flutter_tdd_clean_architecture/core/common/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.email,
      required super.name,
      required super.photoUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
    );
  }
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
