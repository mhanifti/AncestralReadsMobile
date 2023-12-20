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
    String title;
    String language;
    String firstName;
    String lastName;
    int year;
    String subjects;
    int user;
    int amount;

    Fields({
        required this.title,
        required this.language,
        required this.firstName,
        required this.lastName,
        required this.year,
        required this.subjects,
        required this.user,
        required this.amount,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        language: json["language"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        year: json["year"],
        subjects: json["subjects"],
        user: json["user"],
        amount: json["amount"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "language": language,
        "first_name": firstName,
        "last_name": lastName,
        "year": year,
        "subjects": subjects,
        "user": user,
        "amount": amount,
    };
}
