import 'package:ancestralreads/authentication/login.dart';
import 'package:ancestralreads/authentication/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ancestralreads/Kelola/buku.dart';
import 'dart:convert';

class GuestPage extends StatefulWidget {
  const GuestPage({Key? key}) : super(key: key);

  @override
  _GuestPageState createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
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
      //print(d);
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
        surfaceTintColor: const Color(0xff898272),
        backgroundColor: const Color(0xff898272),
        actions: <Widget> [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
                  backgroundColor: MaterialStateProperty.all(const Color(0xff144f36)),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                child: const Text("Log in",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                  },
                  child: const Text("Sign up",
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
        //drawer: const LeftDrawer(),
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
                   const Center(
                     heightFactor: 2.3,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Padding(
                           padding: EdgeInsets.all(14.0),
                           child:Text('Welcome to',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 0.10,
                              ),
                            ),
                         ),
                         Padding(
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
                                leading: Text("${index+1}"),
                                //${snapshot.data![index].pk}
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

