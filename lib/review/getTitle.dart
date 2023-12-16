import 'dart:convert';

Future<String> getTitle(request, id) async {
  var data = jsonEncode({'pk': id});
  final response = await request.post(
    'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/review/get-title/',
    data,
  );
  return response;
}