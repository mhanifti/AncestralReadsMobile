import 'dart:convert';
import 'package:ancestralreads/Kelola/buku.dart';

Future<List<Buku>> fetchBuku(request) async {
  var response = await request.get(
      'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/booklist/get-buku/',
  );
  var data = response;
  List<Buku> listBuku = [];

  for (var d in data) {
    if (d != null) {
      listBuku.add(Buku.fromJson(d));
    }
  }
  return listBuku;
}
