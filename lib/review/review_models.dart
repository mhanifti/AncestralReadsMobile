// To parse this JSON data, do
//
//     final ulasan = ulasanFromJson(jsonString);

import 'dart:convert';

List<Ulasan> ulasanFromJson(String str) => List<Ulasan>.from(json.decode(str).map((x) => Ulasan.fromJson(x)));

String ulasanToJson(List<Ulasan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ulasan {
    String model;
    int pk;
    Fields fields;

    Ulasan({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Ulasan.fromJson(Map<String, dynamic> json) => Ulasan(
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
    int buku;
    String reviewerName;
    String reviewText;
    int rating;
    DateTime reviewDate;
    int user;

    Fields({
        required this.buku,
        required this.reviewerName,
        required this.reviewText,
        required this.rating,
        required this.reviewDate,
        required this.user,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        buku: json["buku"],
        reviewerName: json["reviewer_name"],
        reviewText: json["review_text"],
        rating: json["rating"],
        reviewDate: DateTime.parse(json["review_date"]),
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "buku": buku,
        "reviewer_name": reviewerName,
        "review_text": reviewText,
        "rating": rating,
        "review_date": reviewDate.toIso8601String(),
        "user": user,
    };
}
