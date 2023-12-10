import "../model/Book.dart";

Future<List<Book>> fetchBook(request) async {
  var response = await request.get(
      'http://10.0.2.2:8000/booklist/get-book/'
  );
  var data = response;
  List<Book> listBook = [];

  for (var d in data) {
    if (d != null) {
      listBook.add(Book.fromJson(d));
    }
  }
  return listBook;
}
