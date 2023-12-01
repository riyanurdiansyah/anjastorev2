import 'dart:convert';

ProductM productMFromJson(String str) => ProductM.fromJson(json.decode(str));

String productMToJson(ProductM data) => json.encode(data.toJson());

class ProductM {
  final String name;
  final String code;
  final String id;
  final String created;
  final String updated;
  final int page;

  ProductM({
    required this.name,
    required this.code,
    required this.id,
    required this.created,
    required this.updated,
    required this.page,
  });

  ProductM copyWith({
    String? name,
    String? code,
    String? id,
    String? created,
    String? updated,
    int? page,
  }) =>
      ProductM(
        name: name ?? this.name,
        code: code ?? this.code,
        id: id ?? this.id,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        page: page ?? this.page,
      );

  factory ProductM.fromJson(Map<String, dynamic> json) => ProductM(
        name: json["name"],
        code: json["code"],
        id: json["id"],
        created: json["created"],
        updated: json["updated"],
        page: json["page"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "id": id,
        "created": created,
        "updated": updated,
      };
}
