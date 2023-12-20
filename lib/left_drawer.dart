import 'request/page/request_page.dart';
import 'review/review_page.dart';
import 'booklist/page/booklistpage.dart';
import 'Kelola/menu.dart';
import 'package:flutter/material.dart';
import 'bookmarks/bookmarks_page.dart';

class LeftDrawer extends StatelessWidget {
  final String username;
  const LeftDrawer({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xff144f36),
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff144f36),
            ),
            child: Center (
              child: Text(
                'Ancestral Reads',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFECECEC),
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
                Icons.home_outlined,
              color: Color(0xfff9fffc),
            ),
            title: const Text(
                'Home Page',
                  style: TextStyle(
                  color: Color(0xFFF9FFFC),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(username: username),
                  ));
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.login),
          //   title: const Text(
          //       'Login',
          //         style: TextStyle(
          //         color: Color(0xFFF9FFFC),
          //         fontSize: 20,
          //         fontFamily: 'Poppins',
          //         fontWeight: FontWeight.w400,
          //       ),
          //   ),
          //   // Bagian redirection ke LoginApp
          //   onTap: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const LoginApp(),
          //       )
          //     );
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.app_registration),
          //   title: const Text(
          //       'Register',
          //       style: TextStyle(
          //         color: Color(0xFFF9FFFC),
          //         fontSize: 20,
          //         fontFamily: 'Poppins',
          //         fontWeight: FontWeight.w400,
          //       ),
          //   ),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const RegisterApp(),
          //       )
          //     );
          //   },
          // ),
          
          ListTile(
            leading: const Icon(
                Icons.reviews_outlined,
              color: Color(0xfff9fffc),
            ),
            title: const Text(
                'Book Reviews',
                style: TextStyle(
                  color: Color(0xFFF9FFFC),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Review(username: username),
                  )
                );
              },
            ),
          ListTile(
            leading: const Icon(
                Icons.menu_book,
              color: Color(0xfff9fffc),
            ),
            title: const Text(
                'Booklist',
                style: TextStyle(
                  color: Color(0xFFF9FFFC),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookList(username: username),
                )
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.bookmark_border,
              color: Color(0xfff9fffc),
            ),//left drawernya bookmarks
            title: const Text(
                'Bookmarks',
                style: TextStyle(
                  color: Color(0xFFF9FFFC),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
            ),
            onTap: () {
              // Route menu ke halaman produk
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookmarksPage(username: username)),
              );
            },
          ),
          ListTile( //left drawernya bookmarks
          leading: const Icon(Icons.book_online, color: Color(0xfff9fffc)),
            title: const Text(
                'Book Request',
                style: TextStyle(
                  color: Color(0xFFF9FFFC),
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
            ),
            onTap: () {
              // Route menu ke halaman produk
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductPage(username: username)),
              );
            },
          ),
        ],
      ),
    );
  }
}