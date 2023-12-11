// To parse this JSON data, do
//
//     final buku = bukuFromJson(jsonString);

import 'dart:convert';

List<Buku> bukuFromJson(String str) => List<Buku>.from(json.decode(str).map((x) => Buku.fromJson(x)));

String bukuToJson(List<Buku> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Buku {
  Model model;
  int pk;
  Fields fields;

  Buku({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
    model: modelValues.map[json["model"]]!,
    pk: json["pk"],
    fields: Fields.fromJson(json["fields"]),
  );

  Map<String, dynamic> toJson() => {
    "model": modelValues.reverse[model],
    "pk": pk,
    "fields": fields.toJson(),
  };
}

class Fields {
  int? textNumber;
  String? title;
  Language? language;
  String? firstName;
  String? lastName;
  String? year;
  String? subjects;
  String? bookshelves;

  Fields({
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
    textNumber: json["text_number"],
    title: json["title"],
    language: languageValues.map[json["language"]]!,
    firstName: json["first_name"],
    lastName: json["last_name"],
    year: json["year"],
    subjects: json["subjects"],
    bookshelves: json["bookshelves"],
  );

  Map<String, dynamic> toJson() => {
    "text_number": textNumber,
    "title": title,
    "language": languageValues.reverse[language],
    "first_name": firstName,
    "last_name": lastName,
    "year": year,
    "subjects": subjects,
    "bookshelves": bookshelves,
  };
}

enum Language {
  EN
}

final languageValues = EnumValues({
  "en": Language.EN
});

enum Model {
  PENGELOLA_BUKU
}

final modelValues = EnumValues({
  "pengelola.buku": Model.PENGELOLA_BUKU
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
