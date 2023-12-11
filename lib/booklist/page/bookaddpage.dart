import 'package:flutter/material.dart';

class BookAdd extends StatefulWidget {
  const BookAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<BookAdd> createState() => BookAddPage();
}

class BookAddPage extends State<BookAdd> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: AlignmentDirectional(-0.15, 0.00),
          child: Text(
            'Add Booklist',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: Color.fromRGBO(137, 130, 114, 100.0),
        foregroundColor: Colors.black,
      ),
    );
  }
}