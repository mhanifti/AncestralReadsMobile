// import 'package:ancestralreads/bookmarks/api/fetchBook.dart';
import 'package:ancestralreads/bookmarks/product_detail.page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ancestralreads/bookmarks/models.dart';
import 'package:ancestralreads/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatefulWidget {
    const BookmarksPage({Key? key}) : super(key: key);

    @override
    _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>(); 
     Future<List<Product>> fetchBook() async {

      var response = await request.get(
        'http://127.0.0.1:8000/bookmarks/get-bookmark/'
      );
      var data = response;

      // melakukan konversi data json menjadi object Product
      List<Product> list_product = [];
      for (var d in data) {
          if (d != null) {
              list_product.add(Product.fromJson(d));
          }
      }
      return list_product;
  }
      return Scaffold(
          appBar: AppBar(
          title: const Text('Bookmarks'),
          ),
          drawer: const LeftDrawer(),
          body: FutureBuilder(
              future: fetchBook(),
              builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                  } else {
                      if (!snapshot.hasData) {
                      return const Column(
                          children: [
                          Text(
                              "Tidak ada data produk.",
                              style:
                                  TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                          ],
                      );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 30),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                            "${snapshot.data![index].fields.title}",
                            style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                            ),
                            ),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.firstName} ${snapshot.data![index].fields.lastName}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.language}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.year}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.subjects}"),
                            const SizedBox(height: 10),
                            Text("${snapshot.data![index].fields.bookshelves}"),
                            //tambah tombol delete
                            const SizedBox(height: 10),
                            ElevatedButton(
                            child: const Text('Delete'),
                            onPressed: () async {
                              final url = Uri.parse('http://127.0.0.1:8000/bookmarks/delete-bookmark/');
                              final response = await http.delete(url);

                              if (response.statusCode == 201) {
                                setState(() {
                                  snapshot.data!.removeAt(index);
                                });
                              } 
                            },
                            )


                          ],
                        ),
                      ),
                  );
              }
            }
          }
        )
      );
  }
}