import 'dart:convert';

import 'package:ancestralreads/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../api/fetchBook.dart';

class BookList extends StatefulWidget {
  final String username;
  const BookList({Key? key, required this.username}) : super(key: key);

  @override
  State<BookList> createState() => BooklistPage();
}

class BooklistPage extends State<BookList> {

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
      drawer: LeftDrawer(username: widget.username),
      body: FutureBuilder(
        future: fetchBook(request),
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
                  padding: const EdgeInsetsDirectional.all(8),
                  child: Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(229, 223, 210, 100.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.all(5),
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(start: 25.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 300,
                                        child: Text(
                                          '${snapshot.data?[index].fields.title}',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(height: 4), // Add some space between the title and the details
                                      Container(
                                        width: 300,
                                          child: Text(
                                            '${snapshot.data?[index].fields.firstName} | '
                                                '${snapshot.data?[index].fields.bookshelves} | '
                                                '${snapshot.data?[index].fields.year}',
                                            style: const TextStyle(fontSize: 10),
                                            overflow: TextOverflow.ellipsis,
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                final response = await request.postJson(
                                    'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/booklist/delete-book-flutter/',
                                    jsonEncode(<String, int>{
                                      'pk': snapshot.data[index].pk,
                                    }));
                                if (response['status'] == 'success') {
                                  setState(() {
                                    BooklistPage();
                                  });
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}