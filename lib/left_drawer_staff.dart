import 'Kelola/staff_menu.dart';
import 'package:flutter/material.dart';

class LeftDrawerStaff extends StatelessWidget {
  final String username;
  const LeftDrawerStaff({super.key, required this.username});

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
            child: Center(
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
                'Staff Page',
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
                    builder: (context) => LibrarianPage(username: username),
                  ));
            },
          ),
        ],
      ),
    );
  }
}