import 'dart:convert';

Future<String> getTitle(request, id) async {
  var data = jsonEncode({'pk': id});
  final response = await request.post(
    'http://localhost:8000/review/get-title/',
    data,
  );
  return response;
}