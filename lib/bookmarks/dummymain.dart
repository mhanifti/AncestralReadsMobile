import 'dart:convert';
import 'package:ancestralreads/menu.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ancestralreads/bookmarks/models.dart';
import 'package:ancestralreads/left_drawer.dart';


class ShopFormPage extends StatefulWidget {
    const ShopFormPage({super.key});

    @override
    State<ShopFormPage> createState() => _ShopFormPageState();
}

class _ShopFormPageState extends State<ShopFormPage> {
    final _formKey = GlobalKey<FormState>();
    int _textNumber = 0;
    String _title = "";
    String _firstName = "";
    String _lastName = "";
    String _language = "";
    String _year = "";
    String _subjects = "";
    String _bookshelves = "";

    @override
    Widget build(BuildContext context) {
      final request = context.watch<CookieRequest>();
        return Scaffold(
        appBar: AppBar(
            title: const Center(
            child: Text(
                'Form Tambah Produk',
            ),
            ),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
        ),
        // TODO: Tambahkan drawer yang sudah dibuat di sini
        drawer: const LeftDrawer(),
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
                            hintText: "Judul Buku",
                            labelText: "Judul Buku",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _title = value!;
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
                            hintText: "First Name",
                            labelText: "First Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _title = value!;
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
                            hintText: "Last Name",
                            labelText: "Last Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _title = value!;
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
                            hintText: "Language",
                            labelText: "Language",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _title = value!;
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
                            hintText: "Year",
                            labelText: "Year",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _title = value!;
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
                            hintText: "Subject",
                            labelText: "Subject",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _title = value!;
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
                            hintText: "Bookshelves",
                            labelText: "Bookshelves",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            onChanged: (String? value) {
                            setState(() {
                                _title = value!;
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
                            hintText: "Jumlah",
                            labelText: "Jumlah",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                            ),
                            ),
                            // TODO: Tambahkan variabel yang sesuai
                            onChanged: (String? value) {
                            setState(() {
                                _textNumber = int.parse(value!);
                            });
                            },
                            validator: (String? value) {
                            if (value == null || value.isEmpty) {
                                return "Harga tidak boleh kosong!";
                            }
                            if (int.tryParse(value) == null) {
                                return "Harga harus berupa angka!";
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
                                // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                final response = await request.postJson(
                                "http://127.0.0.1:8000/create-flutter/",
                                jsonEncode(<String, String>{
                                    'text_number': _textNumber.toString(),
                                    'title': _title,
                                    'first_name': _firstName,
                                    'last_name': _lastName,
                                    'language': _language,
                                    'year': _year,
                                    'subjects': _subjects,
                                    'bookshelves': _bookshelves
                                    
                                }));
                                if (response['status'] == 'success') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                    content: Text("Produk baru berhasil disimpan!"),
                                    ));
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => MyHomePage()),
                                    );
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
                       
                    ]

                )
            ),
        ),
        );
    }
}