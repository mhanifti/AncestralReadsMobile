import 'dart:convert';

List<Book> productFromJson(String str) => List<Book>.from(json.decode(str).map((x) => Book.fromJson(x)));

String productToJson(List<Book> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Book {
  String model;
  int pk;
  Fields fields;

  Book({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
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
  int textNumber;
  String title;
  String language;
  String firstName;
  String lastName;
  String year;
  String subjects;
  String bookshelves;
  int user;

  Fields({
    required this.textNumber,
    required this.title,
    required this.language,
    required this.firstName,
    required this.lastName,
    required this.year,
    required this.subjects,
    required this.bookshelves,
    required this.user,
  });

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
    textNumber: json["text_number"],
    title: json["title"],
    language: json["language"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    year: json["year"],
    subjects: json["subjects"],
    bookshelves: json["bookshelves"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "text_number": textNumber,
    "title": title,
    "language": language,
    "first_name": firstName,
    "last_name": lastName,
    "year": year,
    "subjects": subjects,
    "bookshelves": bookshelves,
    "user": user,
  };
}