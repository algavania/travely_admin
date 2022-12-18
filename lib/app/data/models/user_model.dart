import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id, email;
  final String name;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
  });

  factory UserModel.fromMap(String id, Map<dynamic, dynamic> json) {
    return UserModel(
      id: id,
      email: json['email'],
      name: json['name'],
    );
  }

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'name': name,
      'updatedAt': FieldValue.serverTimestamp()
    };
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
      ];
}
