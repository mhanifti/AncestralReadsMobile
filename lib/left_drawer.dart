import 'package:ancestralreads/authentication/login.dart';
import 'package:ancestralreads/authentication/register.dart';
import 'package:ancestralreads/bookmarks/bookmarks_page.dart';
import 'package:ancestralreads/menu.dart';
import 'package:ancestralreads/booklist/page/booklistpage.dart';
import 'package:ancestralreads/guest.dart';
import 'package:flutter/material.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

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
            child: Column(
              children: [
                Text(
                  'Ancestral Reads',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("TBA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Halaman Utama'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GuestPage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Halaman Login'),
            // Bagian redirection ke LoginApp
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginApp(),
                )
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration),
            title: const Text('Halaman Register'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterApp(),
                )
              );
            },
          ),
          ListTile( //left drawernya bookmarks
            leading: const Icon(Icons.shopping_basket),
            title: const Text('Bookmarks'),
            onTap: () {
                // Route menu ke halaman produk
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarksPage()),
                );
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('Halaman Booklist'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BookList(),
                )
              );
            },
          )
        ],
      ),
    );
  }
}