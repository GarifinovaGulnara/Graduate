import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/widgets/list_cards_categories.dart';
import 'package:graduate_work/widgets/profil_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _selectedPage = 0;
  final _widgetOptions = <Widget>[
    const CardsList(),
    const ProfilPage(),
  ];
  void onSelectedPage(int index) {
    if (_selectedPage == index) return; 
    setState(() {
      _selectedPage = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signup_bg,
      appBar: AppBar(
        title: const Text('ХоббиМаркет'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: login_bg,
      ), 
      body: Container(child: _widgetOptions[_selectedPage],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Профиль'),
      ],
      onTap: onSelectedPage,
      ),
    );
  }
}
