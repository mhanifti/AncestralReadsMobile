import "../model/Book.dart";

Future<List<Book>> fetchBook(request) async {
  var response = await request.get(
      'https://ancestralreads-b01-tk.pbp.cs.ui.ac.id/booklist/get-book/'
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
