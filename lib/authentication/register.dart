import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:ancestralreads/authentication/login.dart';

class RegisterApp extends StatelessWidget {
  const RegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RegisterForm(formKey: _formKey),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key, required this.formKey}) : super(key: key);

  final formKey;

  @override
  State<RegisterForm> createState() => _FormRegister();
}

class _FormRegister extends State<RegisterForm> {
  get formKey => widget.formKey;

  String? password = "";
  String? username = "";
  String? password1 = "";
  String? message = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Form(
      key: formKey,
      child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.green,
                  Colors.white,
                  Colors.white,
                  Colors.white,
                ],
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.only(top: 174.0, bottom: 97.0),
                child: Center(
                  child: Text(
                    "AncestralReads",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Register",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username ",
                    filled: true,
                    fillColor: Color.fromARGB(20, 80, 56, 188),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      username = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      username = value!;
                    });
                  },
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
                    fillColor: Color.fromARGB(20, 80, 56, 188),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      password = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      password = value!;
                    });
                  },
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),

                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    filled: true,
                    fillColor: Color.fromARGB(20, 80, 56, 188),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  // Menambahkan behavior saat nama diketik
                  onChanged: (String? value) {
                    setState(() {
                      password1 = value!;
                    });
                  },
                  // Menambahkan behavior saat data disimpan
                  onSaved: (String? value) {
                    setState(() {
                      password1 = value!;
                    });
                  },
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.only(top: 24.0),
                child:Center (
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 20, 79, 54),
                      fixedSize: const Size(250, 32),
                    ),
                    onPressed: () async {
                      final response = await request.post(
                          'http://localhost:8000/auth/register/',
                          {
                            "username": username,
                            "password1": password,
                            "password2": password1,
                            'is_staff': 'true',
                          });

                      if (response['status']==true) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const LoginApp(),
                            ));
                      } else {
                        setState(() {
                          message = response['message'];
                          print(message);
                        });
                      }
                    },
                    child: const Text(
                      "Sign Up as Pustakawan",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.only(top: 5.0),
                child:Center (
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 20, 79, 54),
                      fixedSize: const Size(250, 32),
                    ),
                    onPressed: () async {
                      final response = await request.post(
                          'http://localhost:8000/auth/register/',
                          {
                            "username": username,
                            "password1": password,
                            "password2": password1,
                            'is_staff': '',
                          });

                      if (response['status']==true) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const LoginApp(),
                            ));
                      } else {
                        setState(() {
                          message = response['message'];
                          print(message);
                        });
                      }
                    },
                    child: const Text(
                      "Sign Up as Pembaca",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Center(
                  child: Text(message ?? "",
                    style: const TextStyle(color: Colors.red, fontSize: 16),)),
            ]),
          )),
    );
  }
}