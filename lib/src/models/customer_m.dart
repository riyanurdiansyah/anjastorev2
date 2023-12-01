import 'dart:convert';

CustomerM customerMFromJson(String str) => CustomerM.fromJson(json.decode(str));

String customerMToJson(CustomerM data) => json.encode(data.toJson());

List<CustomerM> customersMFromJson(String str) =>
    List<CustomerM>.from(json.decode(str).map((x) => CustomerM.fromJson(x)));

class CustomerM {
  final String address;
  final String email;
  final String id;
  final String hp;
  final String name;
  final int page;

  CustomerM({
    required this.address,
    required this.email,
    required this.id,
    required this.hp,
    required this.name,
    required this.page,
  });

  CustomerM copyWith({
    String? address,
    String? email,
    String? id,
    String? hp,
    String? name,
    int? page,
  }) =>
      CustomerM(
        address: address ?? this.address,
        email: email ?? this.email,
        id: id ?? this.id,
        hp: hp ?? this.hp,
        name: name ?? this.name,
        page: page ?? this.page,
      );

  factory CustomerM.fromJson(Map<String, dynamic> json) => CustomerM(
        address: json["address"],
        email: json["email"],
        id: json["id"],
        hp: json["hp"],
        name: json["name"],
        page: json["page"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "email": email,
        "id": id,
        "hp": hp,
        "name": name,
      };
}
