// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

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
  int user;
  int textNumber;
  String title;
  String language;
  String firstName;
  String lastName;
  String year;
  String subjects;
  String bookshelves;

  Fields({
    required this.user,
    required this.textNumber,
    required this.title,
    required this.language,
    required this.firstName,
    required this.lastName,
    required this.year,
    required this.subjects,
    required this.bookshelves,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    user: json["user"],
    textNumber: json["text_number"],
    title: json["title"],
    language: json["language"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    year: json["year"],
    subjects: json["subjects"],
    bookshelves: json["bookshelves"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "text_number": textNumber,
    "title": title,
    "language": language,
    "first_name": firstName,
    "last_name": lastName,
    "year": year,
    "subjects": subjects,
    "bookshelves": bookshelves,
  };
}