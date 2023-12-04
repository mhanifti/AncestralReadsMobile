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
      appBar: AppBar(
        title: const Text('Register Account'),
      ),
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
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(20.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(
                child: Text("Register",
                  style: TextStyle(fontSize: 18),),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Username ",
                    icon: const Icon(Icons.title),
                    // Menambahkan icon agar lebih intuitif
                    // Menambahkan circular border agar lebih rapi
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
                  // // Validator sebagai validasi form
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Email tidak boleh kosong!';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password ",
                    icon: const Icon(Icons.password),
                    // Menambahkan icon agar lebih intuitif
                    // Menambahkan circular border agar lebih rapi
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
                  // Validator sebagai validasi form
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Password tidak boleh kosong!';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(8.0),

                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password Confirmation",
                    icon: const Icon(Icons.password),
                    // Menambahkan icon agar lebih intuitif
                    // Menambahkan circular border agar lebih rapi
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
                  // // Validator sebagai validasi form
                  // validator: (String? value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Password tidak boleh kosong!';
                  //   }
                  //   return null;
                  // },
                ),
              ),
              Padding(
                // Menggunakan padding sebesar 8 pixels
                padding: const EdgeInsets.all(24.0),
                child:Center (
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 21, 104, 230)),

                    ),
                    onPressed: () async {
                      final response = await request.post(
                          'http://10.0.2.2:8000/auth/register/',
                          // 'http://$port/flutter_register/',
                          {
                            "username": username,
                            "password1": password,
                            "password2": password1
                          });

                      print(formKey);
                      print(response['status']==false);

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
                      "Simpan",
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