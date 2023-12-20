import 'dart:convert';
import 'package:ancestralreads/review/getTitle.dart';
import 'package:ancestralreads/review/review_models.dart';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/left_drawer.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';


class Review extends StatefulWidget {
  final String username;
  const Review({Key? key, required this.username}) : super(key: key);

  @override
  State<Review> createState() => ReviewPage();
}

class StarRating extends StatelessWidget{
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
  double? _selectedRating;

    // final request = context.watch<CookieRequest>();
    Future<List<Ulasan>> fetchReview(request) async {
      var response = await request.get(
          'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/review/json/',
          
      );
      // melakukan decode response menjadi bentuk json
      var data = response;

      // melakukan konversi data json menjadi object Product
      List<Ulasan> listReview = [];
      for (var d in data) {
        if (d != null) {
          Ulasan review = Ulasan.fromJson(d);
          if (_selectedRating == null || review.fields.rating == _selectedRating) {
            listReview.add(review);
          }
        }
      }

    // Sorting rating list
    listReview.sort((a, b) => a.fields.rating.compareTo(b.fields.rating));

    return listReview;
    

  }

@override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff898272),
        title: const Text(
            'Review',
            //textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
          ),
        ),
      drawer: LeftDrawer(username: widget.username,),
      body: Column(
        children: [
          // Filter Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text('Filter Rating: ${_selectedRating ?? "All"}'),
                Flexible(
                  child: Slider(
                    value: _selectedRating ?? 1,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: 'Selected Rating: ${_selectedRating ?? "All"}',
                    onChanged: (value) {
                      setState(() {
                        _selectedRating = value;
                      });
                    },
                    activeColor: Color(0xff898272),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Fungsi untuk menghapus filter
                    setState(() {
                      _selectedRating = null;
                    });
                  },
                  child: Text('Clear Filter', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff898272), // Ganti warna tombol di sini
                  ),
                ),
              ],
            ),
          ),
          // Review List
          Expanded(
            child:
            FutureBuilder(
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
                          style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Card(
                        color: Color.fromARGB(255, 236, 234, 208),
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FutureBuilder(
                              future: getTitle(request, snapshot.data[index].fields.buku),
                              builder: (context, AsyncSnapshot<String?> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // atau indikator loading lainnya
                                } else if (snapshot.hasError) {
                                  return Text("Error: ${snapshot.error}");
                                } else if (snapshot.data == null) {
                                  return Text("Data kosong"); // Tangani kasus ketika data null
                                } else {
                                  return Text(
                                    snapshot.data!,
                                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  );
                                }
                              },
                            ),
                              const SizedBox(height: 10),
                              Text(
                                "Reviewer: ${snapshot.data[index].fields.reviewerName}",
                                style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 131, 131, 131)),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Date: ${snapshot.data![index].fields.reviewDate}",
                                style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 131, 131, 131)),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              StarRating(rating: snapshot.data![index].fields.rating),
                              const SizedBox(height: 10),
                              Text(
                                "${snapshot.data![index].fields.reviewText}",
                                style: TextStyle(fontSize: 17, color: Color(0xff333333),),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              // tambah tombol delete
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xff144f36), // Warna latar belakang tombol
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0), // Radius sudut untuk membuat kotak dengan sudut bulat
                                  ),
                                ),
                                onPressed: () async {
                                  Map data = {'pk': snapshot.data![index].pk};
                                  final url = Uri.parse('https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/review/delete-ajax/');
                                  final response = await http.delete(
                                    url,
                                    headers: {"Content-Type": "application/json"},
                                    body: jsonEncode(data),
                                  );

                                  if (response.statusCode == 201) {
                                    setState(() {
                                      snapshot.data!.removeAt(index);
                                    });
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10.0), // Sesuaikan padding sesuai kebutuhan
                                  child: Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.white, // Warna teks
                                      fontWeight: FontWeight.bold, // Gaya teks
                                    ),
                                  ),
                                ),
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
          )
        ]
      )
    );
  }
}







              
