import 'package:ancestralreads/authentication/login.dart';
import 'package:ancestralreads/authentication/register.dart';
import 'package:ancestralreads/bookmarks/bookmarks_page.dart';
import 'package:ancestralreads/Kelola/menu.dart';
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
            title: const Text('Halaman Utama',
            style: TextStyle(
              color: Colors.white
            ),
            ),
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
            title: const Text('Login',
            style: TextStyle(
              color: Colors.white
            ),
            ),
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
            title: const Text('Register',
            style: TextStyle(
              color: Colors.white
            ),
            ),
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
            title: const Text('Bookmarks',
            style: TextStyle(
              color: Colors.white
            ),
            ),
            onTap: () {
                // Route menu ke halaman produk
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookmarksPage()),
                );
            },
          ),
          ListTile(
            title: const Text('Booklist',
            style: TextStyle(
              color: Colors.white
            ),
            ),
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