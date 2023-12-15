import 'package:ancestralreads/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:ancestralreads/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/Kelola/buku.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LibrarianPage extends StatefulWidget {
  final String userName;

  const LibrarianPage({Key? key, required this.userName}) : super(key: key);

  @override
  _LibrarianState createState() => _LibrarianState();
}

class _LibrarianState extends State<LibrarianPage> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  int _textNumber = 0;
  String _title = "";
  String _language = "";
  String _firstName = "";
  String _lastName = "";
  String _year = "";
  String _subjects = "";
  String _bookshelves = "";

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

  Future<void> _formDialog(BuildContext context) {
    final request = context.read<CookieRequest>();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: const Color(0xffffffff),
            scrollable: true,
            title: const Text(
              "Data buku baru",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0.10,
              ),
            ),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nomer buku pada koleksi ancestral reads",
                              labelText: "Text Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _textNumber = int.parse(value!);
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Text Number tidak boleh kosong!";
                              }
                              if (int.tryParse(value) == null) {
                                return "Text Number harus berupa angka!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Judul buku yang akan disimpan",
                              labelText: "Title",
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
                                return "Title tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Bahasa dari buku yang akan disimpan",
                              labelText: "Language",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _language = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Language tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nama depan dari pembuat buku",
                              labelText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _firstName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "First Name tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nama belakang dari penulis buku",
                              labelText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _lastName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Last Name tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Tahun rilis buku yang akan disimpan",
                              labelText: "Year",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _year = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Year tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Cakupan buku yang akan disimpan",
                              labelText: "Subjects",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _subjects = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Subjects tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Kategori buku yang akan di simpan",
                              labelText: "Bookshelves",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _bookshelves = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Bookshelves tidak boleh kosong!";
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
                child: FilledButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
                      backgroundColor: MaterialStateProperty.all(const Color(0xff144f36)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        final response = await request.postJson(
                            "http://localhost:8000/create-book/",
                            jsonEncode(<String, String>{
                              'text_number' : _textNumber.toString(),
                              'title': _title,
                              'language': _language,
                              'first_name': _firstName,
                              'last_name' : _lastName,
                              'year' : _year,
                              'subjects' : _subjects,
                              'bookshelves' : _bookshelves
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Buku baru berhasil disimpan!"),
                          ));
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                            Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
                        }
                      }
                    },
                    child: const Text("Simpan buku baru",
                      style: TextStyle(
                        color: Color(0xffededed),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )
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
                    child: const Text("Tutup",
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

  Future<void> _formEditDialog(BuildContext context, int id) {
    final request = context.read<CookieRequest>();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            backgroundColor: const Color(0xffffffff),
            scrollable: true,
            title: const Text(
              "Data buku baru",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                height: 0.10,
              ),
            ),
            content: Form(
              key: _formKey2,
              child: SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nomer buku pada koleksi ancestral reads",
                              labelText: "Text Number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _textNumber = int.parse(value!);
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Text Number tidak boleh kosong!";
                              }
                              if (int.tryParse(value) == null) {
                                return "Text Number harus berupa angka!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Judul buku yang akan disimpan",
                              labelText: "Title",
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
                                return "Title tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Bahasa dari buku yang akan disimpan",
                              labelText: "Language",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _language = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Language tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nama depan dari pembuat buku",
                              labelText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _firstName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "First Name tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nama belakang dari penulis buku",
                              labelText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _lastName = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Last Name tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Tahun rilis buku yang akan disimpan",
                              labelText: "Year",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _year = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Year tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Cakupan buku yang akan disimpan",
                              labelText: "Subjects",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _subjects = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Subjects tidak boleh kosong!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Kategori buku yang akan di simpan",
                              labelText: "Bookshelves",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _bookshelves = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Bookshelves tidak boleh kosong!";
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
                child: FilledButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
                      backgroundColor: MaterialStateProperty.all(const Color(0xff144f36)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Kirim ke Django dan tunggu respons
                        final response = await request.postJson(
                            "http://localhost:8000/edit-flutter/$id",
                            jsonEncode(<String, String>{
                              'text_number' : _textNumber.toString(),
                              'title': _title,
                              'language': _language,
                              'first_name': _firstName,
                              'last_name' : _lastName,
                              'year' : _year,
                              'subjects' : _subjects,
                              'bookshelves' : _bookshelves
                            }));
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Buku baru berhasil disimpan!"),
                          ));
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                            Text("Terdapat kesalahan, silakan coba lagi."),
                          ));
                        }
                      }
                    },
                    child: const Text("Edit buku",
                      style: TextStyle(
                        color: Color(0xffededed),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )
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
                    child: const Text("Tutup",
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
                        "http://localhost:8000/auth/logout/");
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
                        content: Text("$message"),
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
        drawer: const LeftDrawer(),
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
                          child:Text('Hello, ${widget.userName} Welcome to',
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
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: Color(0xffffffff),
              child : FilledButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
                    backgroundColor: MaterialStateProperty.all(const Color(0xff144f36)),
                  ),
                  onPressed: () async => _formDialog(context),
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Text("Ouch!"),
                  // ));
                  child: const Text("Buat buku baru",
                    style: TextStyle(
                      color: Color(0xffededed),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  )
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
                            "Tidak ada data relic.",
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.create_outlined,
                                          size: 20,
                                        ),
                                        onPressed: () async => _formEditDialog(context, snapshot.data![index].pk),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.delete_forever_outlined,
                                          size: 20,
                                        ),
                                        onPressed: () async {
                                          final response = await request.get(
                                              "http://localhost:8000/hapus-flutter/${snapshot.data![index].pk}");
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                            content: Text("buku telah dihapus dan dibuang."),
                                          ));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
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