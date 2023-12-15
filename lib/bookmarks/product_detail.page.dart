import 'package:flutter/material.dart';
import 'package:ancestralreads/left_drawer.dart';
import 'package:ancestralreads/bookmarks/models.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Detail'),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.product.fields.title,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Author: ${widget.product.fields.firstName} ${widget.product.fields.lastName}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Language: ${widget.product.fields.language}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Year: ${widget.product.fields.year}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Subject: ${widget.product.fields.subjects}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Bookshelves: ${widget.product.fields.bookshelves}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Back to List'),
            ),
          ],
        ),
      ),
    );
  }
}

// Text(
//   "${snapshot.data![index].fields.text_number}. "+"${snapshot.data![index].fields.title}",
//   style: const TextStyle(
//       fontSize: 18.0,
//       fontWeight: FontWeight.bold,
//   ),
//   ),
//   const SizedBox(height: 10),
//   Text("${snapshot.data![index].fields.price}"),
//   const SizedBox(height: 10),
//   Text("${snapshot.data![index].fields.first_name}"),
//   const SizedBox(height: 10),
//   Text("${snapshot.data![index].fields.last_name}"),
//   const SizedBox(height: 10),
//   Text("${snapshot.data![index].fields.language}"),
//   const SizedBox(height: 10),
//   Text("${snapshot.data![index].fields.year}"),
//   const SizedBox(height: 10),
//   Text("${snapshot.data![index].fields.subject}"),
//   const SizedBox(height: 10),
//   Text("${snapshot.data![index].fields.bookshelves}")