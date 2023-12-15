import 'dart:convert';

import 'package:ancestralreads/left_drawer.dart';
import 'package:ancestralreads/review/review_page.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ReviewFormPage extends StatefulWidget {
    final int id;
    const ReviewFormPage({super.key, required this.id});

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
            title: const Center(
              child: Text(
                'Form Tambah Review',
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
                        hintText: "Nama Reviewer",
                        labelText: "Nama Reviewer",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
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
                        ),
                      ),
                      // TODO: Tambahkan variabel yang sesuai
                      onChanged: (String? value) {
                        setState(() {
                          _rating = int.parse(value!);
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Rating tidak boleh kosong!";
                        }
                        if (int.tryParse(value) == null) {
                          return "Rating harus berupa angka!";
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
                        ),
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          // TODO: Tambahkan variabel yang sesuai
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
                                        // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                                        final response = await request.postJson(
                                        "http://localhost:8000/review/create-flutter/",
                                        jsonEncode(<String, String>{
                                            'reviewer_name': _nama,
                                            'id_buku': widget.id.toString(),
                                            'rating': _rating.toString(),
                                            'review_text': _deskripsi,
                                            // TODO: Sesuaikan field data sesuai dengan aplikasimu
                                        }));
                                        if (response['status'] == 'success') {
                                             Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const Review(),
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

// import 'package:flutter/material.dart';

// class AddReviewForm extends StatefulWidget {
//   @override
//   _AddReviewFormState createState() => _AddReviewFormState();
// }

// class _AddReviewFormState extends State<AddReviewForm> {
//   final TextEditingController reviewerNameController = TextEditingController();
//   final TextEditingController reviewTextController = TextEditingController();
//   final TextEditingController ratingController = TextEditingController();

//  void addReview() async {
//   final response = await http.post(
//     Uri.parse('http://127.0.0.1:8000/create-review-ajax/'),
//     body: {
//       'reviewer_name': reviewerNameController.text,
//       'review_text': reviewTextController.text,
//       'rating': ratingController.text,
//       'buku': selectedBookId, // Sesuaikan dengan cara Anda mendapatkan ID buku yang dipilih
//     },
//   );

//   if (response.statusCode == 201) {
//     // Review berhasil ditambahkan
//     print('Review added successfully');
    
//     // Kembali ke halaman sebelumnya
//     Navigator.pop(context);
//   } else {
//     // Gagal menambahkan review, Anda dapat menangani error sesuai kebutuhan
//     print('Failed to add review');
//     // Tampilkan pesan error atau ambil tindakan lain yang sesuai
//   }
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Review'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: reviewerNameController,
//               decoration: InputDecoration(labelText: 'Reviewer Name'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: reviewTextController,
//               decoration: InputDecoration(labelText: 'Review Text'),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: ratingController,
//               decoration: InputDecoration(labelText: 'Rating'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 addReview();
//               },
//               child: Text('Add Review'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
