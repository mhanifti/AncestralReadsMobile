import 'package:flutter/material.dart';
import 'package:ancestralreads/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/Kelola/Buku.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ancestral Reads',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      // Masukkan drawer sebagai parameter nilai drawer dari widget Scaffold
      drawer: const LeftDrawer(),
      body: Column(
       children: [
         ConstrainedBox(
           constraints: BoxConstraints(
               minHeight: 120,
               maxHeight: 300,
             ),
           child: Image(image: ,),
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
                          style:
                          TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return Container(
                        color: const Color(0xffe5dfd2),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (_, index) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: ListTile(

                                tileColor: const Color(0xFF898272),
                                leading: Text("${snapshot.data![index].fields.textNumber}"),
                                title: Text("${snapshot.data![index].fields.title}"),
                                subtitle: Text("${snapshot.data![index].fields.lastName}, ${snapshot.data![index].fields.firstName}"),
                                trailing: ListBody(
                                  mainAxis: Axis.horizontal,
                                  children: [
                                    Text("${snapshot.data![index].fields.year}"),

                                    //TODO Button operasi


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

