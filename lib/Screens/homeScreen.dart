import 'package:afam_project/Screens/bookmark_screen.dart';
import 'package:afam_project/Screens/news.dart';
import 'package:afam_project/Screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page.dart';
import 'news_screen.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({Key key}) : super(key: key);

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  int _selectedIndex =0;
  final  List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
     const NewsScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(
          color: Colors.grey[400]
        ),
        unselectedLabelStyle: GoogleFonts.ptSerif(
          color: Colors.grey[400],
          fontSize: 14
        ),
        selectedLabelStyle: GoogleFonts.ptSerif(
            color: const Color(0xff3A4191),
            fontSize: 14
        ),
        unselectedItemColor: Colors.grey[400],
        items:  <BottomNavigationBarItem>[
          const  BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.business),
          //   label: 'Business',
          // ),
          BottomNavigationBarItem(
            icon:  Icon(_selectedIndex !=1 ?Icons.book_outlined: Icons.book),
            label: 'News',
          ),
          // BottomNavigationBarItem(
          //   icon:  Icon(_selectedIndex !=2 ?Icons.favorite_border: Icons.favorite),
          //   label: 'News',
          // ),
          BottomNavigationBarItem(
            icon:  Icon(_selectedIndex !=3 ?Icons.settings: Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xff3A4191),
        onTap: _onItemTapped,
      ),
    );
  }
}
