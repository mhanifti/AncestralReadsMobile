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
          'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/bookmarks/get-bookmark/'
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
          backgroundColor: const Color(0xff898272),
          title: const Text('Bookmarks',
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins'
              )
          ),
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
                      decoration: BoxDecoration(
                          color: const Color(0xFFe5dfd2),
                          borderRadius: BorderRadius.circular(15.0)
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 4
                      ),
                      child: ListTile(
                          tileColor: const Color(0xFFe5dfd2),
                          leading: Text("${index+1}"),
                          title: Text(
                            "${snapshot.data![index].fields.title}.",
                            style: const TextStyle(
                                color: Color(0xff333333),
                                fontSize: 17,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                overflow: TextOverflow.ellipsis
                            ),
                          ),
                          subtitle: Text(
                            "${snapshot.data![index].fields.firstName} ${snapshot.data![index].fields.lastName}"
                                " | ${snapshot.data![index].fields.bookshelves} | ${snapshot.data![index].fields.year}",
                            style: const TextStyle(
                              color: Color(0xff333333),
                              fontSize: 10,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing:IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              Map data = {'pk':snapshot.data![index].pk};
                              final url = Uri.parse('http://localhost:8000/bookmarks/delete-bookmark/');
                              final response = await http.delete(
                                  url,
                                  headers: {"Content-Type": "application/json"},
                                  body: jsonEncode(data));

                              if (response.statusCode == 201) {
                                setState(() {
                                  snapshot.data!.removeAt(index);
                                });
                              }
                            },
                          )
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