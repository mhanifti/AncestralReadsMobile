import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  String model;
  int pk;
  Fields fields;

  Product({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    model: json["model"],
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  String title;
  DateTime dateAdded;
  int year;
  String firstName;
  int user;

  Fields({
    required this.title,
    required this.dateAdded,
    required this.year,
    required this.firstName,
    required this.user,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    title: json["title"],
    dateAdded: DateTime.parse(json["date_added"]),
    year: json["year"],
    firstName: json["first_name"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "date_added": "${dateAdded.year.toString().padLeft(4, '0')}-${dateAdded.month.toString().padLeft(2, '0')}-${dateAdded.day.toString().padLeft(2, '0')}",
    "year": year,
    "first_name": firstName,
    "user": user,
  };
}