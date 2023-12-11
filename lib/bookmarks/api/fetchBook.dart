
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/bookmarks/models.dart';
//TODO: coba pake http
// Future<List<Product>> fetchBook(request) async {
//     // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
//     var response = await request.get(
//         'http://localhost:8000/bookmarks/json/'
//     );

//     // melakukan decode response menjadi bentuk json
//     var data = response;

//     // melakukan konversi data json menjadi object Product
//     List<Product> list_product = [];
//     for (var d in data) {
//         if (d != null) {
//             list_product.add(Product.fromJson(d));
//         }
//     }
//     return list_product;
// }

// Future<List<Product>> fetchBook() async {
//     // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
//     var url = Uri.parse(
//         'http://localhost:8000/bookmarks/json/');
//     var response = await http.get(
//         url,
//         headers: {"Content-Type": "application/json"},
//     );

//     // melakukan decode response menjadi bentuk json
//     var data = jsonDecode(utf8.decode(response.bodyBytes));

//     // melakukan konversi data json menjadi object Product
//     List<Product> list_product = [];
//     for (var d in data) {
//         if (d != null) {
//             list_product.add(Product.fromJson(d));
//         }
//     }
//     return list_product;
// }
