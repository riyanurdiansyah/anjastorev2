import 'dart:convert';

ExpenseM expenseMFromJson(String str) => ExpenseM.fromJson(json.decode(str));

String expenseMToJson(ExpenseM data) => json.encode(data.toJson());

class ExpenseM {
  final String image;
  final int expense;
  final String note;
  final String id;
  final String created;
  final String updated;
  final int page;

  ExpenseM({
    required this.image,
    required this.expense,
    required this.note,
    required this.id,
    required this.created,
    required this.updated,
    required this.page,
  });

  ExpenseM copyWith({
    String? image,
    int? expense,
    String? note,
    String? id,
    String? created,
    String? updated,
    int? page,
  }) =>
      ExpenseM(
        image: image ?? this.image,
        expense: expense ?? this.expense,
        note: note ?? this.note,
        id: id ?? this.id,
        created: created ?? this.created,
        updated: updated ?? this.updated,
        page: page ?? this.page,
      );

  factory ExpenseM.fromJson(Map<String, dynamic> json) => ExpenseM(
        image: json["image"],
        expense: json["expense"],
        note: json["note"],
        id: json["id"],
        created: json["created"],
        updated: json["updated"],
        page: json["page"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "expense": expense,
        "note": note,
        "id": id,
        "created": created,
        "updated": updated,
        "page": page,
      };
}
