import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../api/fetchBuku.dart';
import 'package:ancestralreads/Kelola/buku.dart';

class BookAdd extends StatefulWidget {
  const BookAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<BookAdd> createState() => BookaddPage();
}

class BookaddPage extends State<BookAdd> {
  Buku? dropdownValue;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: AlignmentDirectional(0.00, 5.00),
          child: Text(
            'BookAdd',
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
      body: Column(
        children: [
          Container(
            child: FutureBuilder(
              future: fetchBuku(request),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    dropdownValue ??= snapshot.data?[1];
                    return Container(
                      alignment: AlignmentDirectional.center,
                      margin: const EdgeInsetsDirectional.all(8.0),
                      child: DropdownMenu<Buku>(
                        width: 350.0,
                        initialSelection: dropdownValue,
                        menuHeight: 500.0,
                        onSelected: (Buku? value) {
                          setState(() {
                            dropdownValue = value;
                          });
                        },
                        dropdownMenuEntries: snapshot.data!.map<DropdownMenuEntry<Buku>>((Buku item) {
                          final String labelText = '${item.fields.title}';
                          return DropdownMenuEntry<Buku>(
                            value: item,
                            label: labelText,
                            labelWidget: Text(
                              labelText,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return Text('Sudah terbooklist semua');
                  }
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateColor.resolveWith((states) => Colors.deepPurpleAccent),
            padding: MaterialStateProperty.resolveWith((states) => const EdgeInsetsDirectional.all(20.0)),
          ),
          onPressed: () async {
            var data = jsonEncode({'pk': dropdownValue?.pk});
            final response = await request.post(
              'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/booklist/add-book-flutter/',
              data,
            );
            if (response['status'] == 'success') {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                  content: Text("Buku berhasil ditambah ke booklist!")
              ));
            } else if (response['status'] == 'duplicate') {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                  content: Text("Buku sudah ada dalam booklist anda!")
              ));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(
                  content: Text("Terjadi error saat penambahan buku")
              ));
            }
          },
          child: Text(
            'Simpan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}