// Import External
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

// Import Internal
import 'package:ancestralreads/left_drawer.dart';
import '../api/fetchBook.dart';
import '../page/bookaddpage.dart';

class BookList extends StatefulWidget {
  final String username;
  const BookList({Key? key, required this.username}) : super(key: key);

  @override
  State<BookList> createState() => BooklistPage();
}

class BooklistPage extends State<BookList> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff898272),
        title: const Text(
            'Booklist',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
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
                    decoration: BoxDecoration(
                      color: const Color(0xFFe5dfd2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading: Text('${count++}'),
                      title: Text(
                        '${snapshot.data?[index].fields.title}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                      subtitle: Text(
                        '${snapshot.data?[index].fields.firstName} | '
                            '${snapshot.data?[index].fields.bookshelves} | '
                            '${snapshot.data?[index].fields.year}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 10),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          final response = await request.postJson(
                              'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/booklist/delete-book-flutter/',
                              jsonEncode(<String, int>{
                                'pk': snapshot.data[index].pk,
                              }));
                          if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text("Buku telah dihapus!"),
                                duration: Duration(seconds: 1),
                            ));
                            setState(() {
                              BooklistPage();
                            });
                          } else if (response['status'] == 'not found') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                content: Text("Buku sudah terhapus sebelumnya!"),
                                duration: Duration(seconds: 1),
                            ));
                            setState(() {
                              BooklistPage();
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
              MaterialPageRoute(
                builder: (context) => BookAdd(username: widget.username),
              )
          );
        },
      ),
    );
  }
}