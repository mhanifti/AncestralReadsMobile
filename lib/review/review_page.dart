import 'dart:convert';
import 'package:ancestralreads/review/review_models.dart';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class Review extends StatefulWidget {
  const Review({
    Key? key,
  }) : super(key: key);

  @override
  State<Review> createState() => ReviewPage();
}

class StarRating extends StatelessWidget {
  final int rating;

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center stars horizontally
      crossAxisAlignment: CrossAxisAlignment.center, // Center stars vertically
      children: List.generate(
        rating,
        (index) => Icon(Icons.star, color: Colors.yellow),
      ),
    );
  }
}


class ReviewPage extends State<Review> {

    // final request = context.watch<CookieRequest>();
    Future<List<Ulasan>> fetchReview(request) async {
      // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
      var response = await request.get(
          'http://127.0.0.1:8000/review/json/',
          
      );

      // melakukan decode response menjadi bentuk json
      var data = response;

      // melakukan konversi data json menjadi object Product
      List<Ulasan> listReview = [];
      for (var d in data) {
          if (d != null) {
              listReview.add(Ulasan.fromJson(d));
          }
      }
      return listReview;
  }

@override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: AlignmentDirectional(0.00, 5.00),
          child: Text(
            'Review',
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
      
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchReview(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    "Belum ada buku yang di-Review.",
                    style: TextStyle(color: Color.fromARGB(255, 14, 14, 14), fontSize: 20),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Card(
                  color: Color.fromARGB(255, 211, 210, 183),
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${snapshot.data![index].fields.buku}",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center, // Center horizontally
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Reviewer: ${snapshot.data[index].fields.reviewerName}",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${snapshot.data![index].fields.reviewText}",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        StarRating(rating: snapshot.data![index].fields.rating),
                        const SizedBox(height: 10),
                        Text(
                          "Date: ${snapshot.data![index].fields.reviewDate}",
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        // tambah tombol delete
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 180, 204, 176), // Change button color
                          ),
                          child: const Text('Delete'),
                          onPressed: () async {
                            final url =
                                Uri.parse('http://127.0.0.1:8000/review/delete-ajax/');
                            final response = await http.delete(url);

                            if (response.statusCode == 201) {
                              setState(() {
                                snapshot.data!.removeAt(index);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

// import 'dart:convert';
// import 'package:ancestralreads/review/review_models.dart';
// import 'package:http/http.dart' as http;
// import 'package:ancestralreads/left_drawer.dart';
// import 'package:flutter/material.dart';
// import 'package:pbp_django_auth/pbp_django_auth.dart';
// import 'package:provider/provider.dart';

// class Review extends StatefulWidget {
//   const Review({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<Review> createState() => ReviewPage();
// }

// class StarRating extends StatelessWidget {
//   final int rating;

//   StarRating({required this.rating});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center, // Center stars horizontally
//       crossAxisAlignment: CrossAxisAlignment.center, // Center stars vertically
//       children: List.generate(
//         rating,
//         (index) => Icon(Icons.star, color: Colors.yellow),
//       ),
//     );
//   }
// }

// class ReviewPage extends State<Review> {
//   Future<List<Ulasan>> fetchReview(request) async {
//     var response = await request.get('http://127.0.0.1:8000/review/json/');

//     if (response.statusCode == 200) {
//       var data = json.decode(response.body);

//       List<Ulasan> listReview = [];
//       for (var d in data) {
//         if (d != null) {
//           d['fields']['buku'] = await fetchBookTitle(request, d['fields']['buku']);
//           listReview.add(Ulasan.fromJson(d));
//         }
//       }
//       return listReview;
//     } else {
//       throw Exception('Failed to load reviews');
//     }
//   }

//   Future<String> fetchBookTitle(request, int bookId) async {
//     var bookResponse = await request.get('http://127.0.0.1:8000/book/$bookId/');

//     if (bookResponse.statusCode == 200) {
//       var bookData = json.decode(bookResponse.body);
//       return bookData['title'];
//     } else {
//       return '';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();
//     return Scaffold(
//       appBar: AppBar(
//         title: const Align(
//           alignment: AlignmentDirectional(0.00, 5.00),
//           child: Text(
//             'Review',
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontFamily: 'Outfit',
//               color: Colors.black,
//               fontSize: 30,
//             ),
//           ),
//         ),
//         backgroundColor: Color.fromRGBO(137, 130, 114, 100.0),
//         foregroundColor: Colors.black,
//       ),
//       drawer: const LeftDrawer(),
//       body: FutureBuilder(
//         future: fetchReview(request),
//         builder: (context, AsyncSnapshot<List<Ulasan>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text(
//                 "Belum ada buku yang di-Review.",
//                 style: TextStyle(color: Color.fromARGB(255, 14, 14, 14), fontSize: 20),
//               ),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (_, index) => Card(
//                 color: Color.fromARGB(255, 211, 210, 183),
//                 elevation: 5,
//                 margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         "${snapshot.data![index].fields.buku}",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         "Reviewer: ${snapshot.data![index].fields.reviewerName}",
//                         style: TextStyle(color: Colors.grey),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         "${snapshot.data![index].fields.reviewText}",
//                         style: TextStyle(fontSize: 16),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 10),
//                       StarRating(rating: snapshot.data![index].fields.rating),
//                       const SizedBox(height: 10),
//                       Text(
//                         "Date: ${snapshot.data![index].fields.reviewDate}",
//                         style: TextStyle(color: Colors.grey),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 10),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: Color.fromARGB(255, 180, 204, 176),
//                         ),
//                         child: const Text('Delete'),
//                         onPressed: () async {
//                           final url =
//                               Uri.parse('http://127.0.0.1:8000/review/delete-ajax/');
//                           final response = await http.delete(url);

//                           if (response.statusCode == 201) {
//                             setState(() {
//                               snapshot.data!.removeAt(index);
//                             });
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }



              
