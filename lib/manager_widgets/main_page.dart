import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/manager_widgets/profil_widget.dart';

import 'home_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  int _selectedPage = 0;
  final _widgetOptions = <Widget>[
    const HomeWidget(),
    ProfilWidget(),
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
        automaticallyImplyLeading: false,
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
