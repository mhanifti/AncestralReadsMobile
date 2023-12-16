//
//}


  /////////////////////////////////////////////////////////////////////////////
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
