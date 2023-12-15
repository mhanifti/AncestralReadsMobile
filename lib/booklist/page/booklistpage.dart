import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../model/Book.dart';

class BookList extends StatefulWidget {
  const BookList({
    Key? key,
  }) : super(key: key);

  @override
  State<BookList> createState() => BooklistPage();
}

class BooklistPage extends State<BookList> {

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Future<List<Book>> fetchBook() async {
      var response = await request.get(
        'http://127.0.0.1:8000/booklist/get-book-ft/'
      );
      var data = response;
      List<Book> listBook = [];

      for (var d in data) {
        if (d != null) {
          listBook.add(Book.fromJson(d));
        }
      }
      return listBook;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: AlignmentDirectional(0.00, 5.00),
          child: Text(
            'Booklist',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.black,
              fontSize: 30,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(137, 130, 114, 100.0),
        foregroundColor: Colors.black,
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchBook(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data.length == 0) {
              return const Column(
                children: [
                  Text(
                    "Belum ada Booklist",
                  )
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    height: 50,
                    child: Center(
                        child: Text(
                        "${snapshot.data[index].fields.title}"
                      )
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(229, 223, 210, 100.0),
                    ),
                  ),
                ),
              );
            }
          }
        },
      )
    );
  }
}