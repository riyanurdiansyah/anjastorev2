import 'dart:convert';

import 'package:equatable/equatable.dart';

UserM userFromJson(String str) => UserM.fromJson(json.decode(str));

String userToJson(UserM data) => json.encode(data.toJson());

class UserM extends Equatable {
  final String email;
  final String updated;
  final String id;
  final String created;
  final String name;
  final int role;
  final int page;

  const UserM({
    required this.email,
    required this.updated,
    required this.id,
    required this.created,
    required this.name,
    required this.role,
    required this.page,
  });

  UserM copyWith({
    String? email,
    String? updated,
    String? id,
    List<String>? quizes,
    String? created,
    String? username,
    String? name,
    String? position,
    int? role,
    int? page,
  }) =>
      UserM(
        email: email ?? this.email,
        updated: updated ?? this.updated,
        id: id ?? this.id,
        created: created ?? this.created,
        name: name ?? this.name,
        role: role ?? this.role,
        page: page ?? this.page,
      );

  factory UserM.fromJson(Map<String, dynamic> json) => UserM(
        email: json["email"] ?? "",
        updated: json["updated"] ?? DateTime.now().toIso8601String(),
        id: json["id"] ?? "",
        created: json["created"] ?? DateTime.now().toIso8601String(),
        role: json["role"] ?? 99,
        name: json["name"] ?? "",
        page: json["page"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "updated": updated,
        "id": id,
        "created": created,
        "role": role,
        "name": name,
      };

  @override
  List<Object?> get props => [email, id, updated, created, role, name];
}
