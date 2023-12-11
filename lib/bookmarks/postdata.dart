//ini buat ngepost data dari punya catur
//fungsionalitasnya mirip shoplist_form.dart
//btr dulu ya gatau caranya

//bikin class 
//widjet build
//return scaffold

//children align onpressed blabla2

Align(
alignment: Alignment.bottomCenter,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: ElevatedButton(
style: ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all(Colors.indigo),
),
onPressed: () async {
if (_formKey.currentState!.validate()) {
    // Kirim ke Django dan tunggu respons
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    final response = await request.postJson(
    "http://127.0.0.1:8000/create-flutter/",
    jsonEncode(<String, String>{
        'title': _title,
        'amount': _amount.toString(),
        'description': _description,
        // TODO: Sesuaikan field data sesuai dengan aplikasimu
    }));
    if (response['status'] == 'success') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
        content: Text("Produk baru berhasil disimpan!"),
        ));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
        );
    } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
            content:
                Text("Terdapat kesalahan, silakan coba lagi."),
        ));
    }
}
},

child: const Text(
    "Save",
    style: TextStyle(color: Colors.white),
),
),
),
)
