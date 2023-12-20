import 'dart:convert';
import 'package:ancestralreads/left_drawer.dart';
import 'package:ancestralreads/review/review_page.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewFormPage extends StatefulWidget {
    final String username;
    final int id;
    const ReviewFormPage({super.key, required this.id, required this.username});

    @override
    State<ReviewFormPage> createState() => _ReviewFormPageState();

}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final _formKey = GlobalKey<FormState>();
  
  String _nama = "";
  int _rating = 0;
  String _deskripsi = "";

    @override
    Widget build(BuildContext context) {
        final request = context.watch<CookieRequest>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff898272),
            title: const Text('Add Book Review',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700
            )
            ),
          ),
          drawer: LeftDrawer(username: widget.username),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Nama Reviewer",
                        labelText: "Nama Reviewer",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff144F36), width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff144F36), width: 2.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _nama = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Nama tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),
                                   
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Rating",
                        labelText: "Rating",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff144F36), width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff144F36), width: 2.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _rating = int.tryParse(value ?? "")!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Rating tidak boleh kosong!";
                        }

                        int? rating = int.tryParse(value);
                        if (rating == null) {
                          return "Rating harus berupa angka!";
                        }

                        if (rating <= 0 || rating > 5) {
                          return "Rating harus antara 1 dan 5!";
                        }

                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Deskripsi",
                        labelText: "Deskripsi",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(color: Color(0xff144F36), width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff144F36), width: 2.0),
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _deskripsi = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Deskripsi review tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),
              
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.indigo),
                                ),

                                onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                        // Kirim ke Django dan tunggu respons
                                        final response = await request.postJson(
                                        "https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/review/create-flutter/",
                                        jsonEncode(<String, String>{
                                            'username' : widget.username,
                                            'reviewer_name': _nama,
                                            'id_buku': widget.id.toString(),
                                            'rating': _rating.toString(),
                                            'review_text': _deskripsi,
                                        }));
                                        if (response['status'] == 'success') {
                                             Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Review(username: widget.username),
                                              ));
                                        } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                content:
                                                    Text("Terdapat kesalahan, silakan coba lagi."),
                                            ));
                                        }
                                    }
                                },

                                child: const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),

                    ),
                  ),
           ]),

          ),
        ));
      }
  }


