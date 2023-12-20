import 'package:ancestralreads/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:ancestralreads/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/Kelola/buku.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import '../review/review_page.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _formKey3 = GlobalKey<FormState>();
  String _nama = "";
  int _rating = 0;
  String _deskripsi = "";

  Future<List<Buku>> fetchBuku() async {
    var url = Uri.parse(
        'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/json/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Buku> list_buku = [];
    for (var d in data) {
      if (d != null) {
        list_buku.add(Buku.fromJson(d));
      }
    }
    return list_buku;
  }

  Future<void> _formDialog(BuildContext context, int id) {
    final request = context.read<CookieRequest>();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: Color.fromARGB(255, 218, 213, 201),
            scrollable: true,
            title: const Text(
              "Add Book Review",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Form(
              key: _formKey3,
              child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
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
                              _rating = int.parse(value!);
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
                    ]
                  )
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xff144f36)), // Warna hijau kustom
                    shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder())
                  ),
                  onPressed: () async {
                    if (_formKey3.currentState!.validate()) {
                      // Kirim ke Django dan tunggu respons
                      final response = await request.postJson(
                        "https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/review/create-flutter/",
                        jsonEncode(<String, String>{
                          'username': widget.username,
                          'reviewer_name': _nama,
                          'id_buku': id.toString(),
                          'rating': _rating.toString(),
                          'review_text': _deskripsi,
                        }),
                      );
                      if (response['status'] == 'success') {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Review(username: widget.username),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Terdapat kesalahan, silakan coba lagi."),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: FilledButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
                      backgroundColor: MaterialStateProperty.all(const Color(0xff144f36)),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Close",
                      style: TextStyle(
                        color: Color(0xffededed),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )
                ),
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: const Color(0xff898272),
          backgroundColor: const Color(0xff898272),
          actions: <Widget> [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: Text("Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 0.10,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
                    backgroundColor: MaterialStateProperty.all(const Color(0xff144f36)),
                  ),
                  onPressed: () async {
                    final response = await request.logout(
                        "https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/auth/logout/");
                    String message = response["message"];
                    if (response['status']) {
                      String uname = response["username"];
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("$message Sampai jumpa, $uname."),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('$message'),
                      ));
                    }
                  },
                  child: const Text("Log out",
                    style: TextStyle(
                      color: Color(0xffededed),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )
              ),
            ),
          ],
        ),
        // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
        drawer: LeftDrawer(username: widget.username,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              alignment: Alignment.center,
              color: const Color(0xff144f36),
              height: 150,
              width: double.maxFinite,
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: FittedBox(
                      clipBehavior: Clip.antiAlias,
                      fit: BoxFit.fill,
                      child: Image.asset('asset/image_1.png', scale: 2),
                    ),
                  ),
                  Center(
                    heightFactor: 2.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child:Text('Hello, ${widget.username} Welcome to',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(14.0),
                          child:Text('Ancestral Reads',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700,
                              height: 0.10,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            FutureBuilder(
                future: fetchBuku(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData) {
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tidak ada data buku.",
                            style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 4
                              ),
                              child: ListTile(
                                tileColor: const Color(0xFFe5dfd2),
                                leading: Text("${snapshot.data![index].fields.textNumber}"),
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
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.bookmark_add_outlined),
                                      onPressed: () async {
                                        var data = jsonEncode({'pk': snapshot.data![index].pk});
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
                                    ),
                                    IconButton (
                                        icon: const Icon(Icons.reviews_outlined),
                                        onPressed: () async =>  _formDialog(context, snapshot.data![index].pk),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.bookmark_add),
                                      onPressed: () async {
                                        var data = jsonEncode({'bookId': snapshot.data![index].pk});
                                        final response = await request.post(
                                            'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/bookmarks/add-bookmark/',
                                            data,
                                        );
                                        if (response['status'] == 'ok') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                              content: Text("Buku berhasil ditambah ke bookmark!")
                                          ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                              content: Text("Buku sudah pernah ditambah ke bookmark!")
                                          ));
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ),
                            )
                        ),
                      );
                    }
                  }
                }
            )
          ],
        )
    );
  }
}