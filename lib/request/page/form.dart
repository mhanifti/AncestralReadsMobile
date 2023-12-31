import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ancestralreads/request/page/request_page.dart';
import 'package:ancestralreads/left_drawer.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RequestFormPage extends StatefulWidget {
  final String username;
  const RequestFormPage({Key? key, required this.username}) : super(key: key);

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  int _year = 0;
  String _firstName = "";

  Future<void> addBook() async {
    final url = Uri.parse(
        'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/request_book/create-product-flutter/'); // Ganti dengan URL API Django Anda
    final response = await http.post(url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': widget.username,
          'language': "",
          'title': _title,
          'year': _year.toString(),
          'first_name': _firstName,
          'last_name': "",
          'subjects': "",
        }));

    if (response.statusCode == 201) {
      // Berhasil menyimpan buku
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Buku baru berhasil disimpan!")),
      );
      // Anda mungkin ingin navigasi ke halaman lain atau refresh state
      Future.delayed(const Duration(seconds: 2), () {
        // Atau, jika Anda ingin mengganti halaman saat ini dengan home, gunakan:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => ProductPage(username: widget.username,)));
      });
    } else {
      // Terjadi kesalahan
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Terdapat kesalahan, silakan coba lagi.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Add Request Book',
          ),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(
        username: '',
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Book Title",
                labelText: "Book Title",
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
                  return "Judul buku tidak boleh kosong!";
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
                  _year = int.parse(value!);
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Tahun tidak boleh kosong!";
                }
                if (int.tryParse(value) == null) {
                  return "Tahun harus berupa angka!";
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
                  _firstName = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "First Name tidak boleh kosong";
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
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    addBook();
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
