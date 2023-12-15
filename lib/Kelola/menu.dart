import 'package:ancestralreads/authentication/login.dart';
import 'package:ancestralreads/authentication/register.dart';
import 'package:ancestralreads/review/review_form.dart';
import 'package:flutter/material.dart';
import 'package:ancestralreads/left_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/Kelola/Buku.dart';
import 'dart:convert';
import 'package:ancestralreads/main.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  Future<List<Buku>> fetchBuku() async {
    var url = Uri.parse(
        'http://127.0.0.1:8000/json/');
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
                        "http://127.0.0.1:8000/auth/logout/");
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
                                trailing: IconButton (
                                  icon: Icon(Icons.reviews_outlined),
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReviewFormPage(id:snapshot.data![index].pk),
                                      )
                                    );
                                  }
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