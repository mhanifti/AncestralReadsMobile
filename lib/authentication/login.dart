import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:ancestralreads/Kelola/menu.dart';
import 'package:ancestralreads/Kelola/staff_menu.dart';

import 'register.dart';
class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: FittedBox(
              clipBehavior: Clip.antiAlias,
              fit: BoxFit.fill,
              child: Image.asset('asset/image_3.png', scale: 2),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 174.0, bottom: 97.0),
                  child: Center(
                    child: Text(
                      "AncestralReads",
                      style: TextStyle(
                        color: Color(0xFFECECEC),
                        fontSize: 48,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Username ",
                      filled: true,
                      fillColor: const Color(0xBBCCE4F2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    controller: _usernameController,
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password ",
                      filled: true,
                      fillColor: const Color(0xBBCCE4F2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    controller: _passwordController,
                  ),
                ),
                const SizedBox(height: 24.0),
                Center(
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
                          backgroundColor: MaterialStateProperty.all(const Color(0xff144f36)),
                        ),
                        onPressed: () async {
                          String username = _usernameController.text;
                          String password = _passwordController.text;
                          final response = await request.login("https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/auth/login/", {
                            'username': username,
                            'password': password,
                          });

                          if (request.loggedIn) {
                            if (response['is_staff']) {
                              String message = response['message'];
                              String uname = response['username'];
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LibrarianPage(username: uname),
                                  ));
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                    SnackBar(
                                        content: Text("$message Selamat datang, $uname."))
                                );
                            } else {
                              String message = response['message'];
                              String uname = response['username'];
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage(username: uname)),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                    SnackBar(
                                        content: Text("$message Selamat datang, $uname."))
                                );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Login Gagal'),
                                content: Text(response['message']),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Color(0xFFE7E7E7),
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            expand: true,
            snap: true,
            snapSizes: [
              0.18,
              0.32
            ],
            initialChildSize: 0.18,
            minChildSize: 0.18,
            maxChildSize: 0.35,
            builder: (BuildContext contex, ScrollController scrollController){
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      color: Color(0xFFE7E7E7)
                  ),
                  height: 300,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20
                        ),
                        child: Container(
                          width: 80,
                          height: 5,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            color: Color(0xFFD2DBF6),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20
                        ),
                        child: Center(
                            child: Text(
                              'Don’t have an account?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            )
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20
                          ),
                          child: SizedBox(
                            height: 40,
                            width: 140,
                            child: TextButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<OutlinedBorder>(const RoundedRectangleBorder()),
                                backgroundColor: MaterialStateProperty.all(const Color(0xff144f36)),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ));
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  color: Color(0xFFE7E7E7),
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}