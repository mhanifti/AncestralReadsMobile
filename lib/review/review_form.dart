// import 'package:ancestralreads/left_drawer.dart';
// import 'package:flutter/material.dart';
// // TODO: Impor drawer yang sudah dibuat sebelumnya

// class ReviewFormPage extends StatefulWidget {
//     const ReviewFormPage({super.key});

//     @override
//     State<ReviewFormPage> createState() => _ReviewFormPageState();
// }

// class _ReviewFormPageState extends State<ReviewFormPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _nama = "";
//   int _rating = 0;
//   String _deskripsi = "";
//     @override
//     Widget build(BuildContext context) {
//         return Scaffold(
//           appBar: AppBar(
//             title: const Center(
//               child: Text(
//                 'Form Tambah Review',
//               ),
//             ),
//             backgroundColor: Colors.indigo,
//             foregroundColor: Colors.white,
//           ),
//           // TODO: Tambahkan drawer yang sudah dibuat di sini
//           drawer: const LeftDrawer(),
//           body: Form(
//             key: _formKey,
//             child: SingleChildScrollView(
//                 child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         hintText: "Nama Reviewer",
//                         labelText: "Nama Reviewer",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                       onChanged: (String? value) {
//                         setState(() {
//                           _nama = value!;
//                         });
//                       },
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return "Nama tidak boleh kosong!";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
             
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         hintText: "Rating",
//                         labelText: "Rating",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                       // TODO: Tambahkan variabel yang sesuai
//                       onChanged: (String? value) {
//                         setState(() {
//                           _rating = int.parse(value!);
//                         });
//                       },
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return "Rating tidak boleh kosong!";
//                         }
//                         if (int.tryParse(value) == null) {
//                           return "Rating harus berupa angka!";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                         hintText: "Deskripsi",
//                         labelText: "Deskripsi",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                       onChanged: (String? value) {
//                         setState(() {
//                           // TODO: Tambahkan variabel yang sesuai
//                           _deskripsi = value!;
//                         });
//                       },
//                       validator: (String? value) {
//                         if (value == null || value.isEmpty) {
//                           return "Deskripsi review tidak boleh kosong!";
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
              
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
                      
//                       child: ElevatedButton(
//                                 style: ButtonStyle(
//                                   backgroundColor:
//                                       MaterialStateProperty.all(Colors.indigo),
//                                 ),
//                                 onPressed: () {
//                                   if (_formKey.currentState!.validate()) {
//                                     showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           title: const Text('Produk berhasil tersimpan'),
//                                           content: SingleChildScrollView(
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Text('Nama: $_nama'),
//                                                 // TODO: Munculkan value-value lainnya
//                                               ],
//                                             ),
//                                           ),
//                                           actions: [
//                                             TextButton(
//                                               child: const Text('OK'),
//                                               onPressed: () {
//                                                 Navigator.pop(context);
//                                               },
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   _formKey.currentState!.reset();
//                                   }
//                                 },
//                                 child: const Text(
//                                   "Save",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),

//                     ),
//                   ),


//            ]),

//           ),
//         ));
//             }
//         }

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
