import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/unauth_user_widgets/unauth_list_cards_categ.dart';
import 'package:graduate_work/unauth_user_widgets/unauth_profil_page.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({super.key});

  @override
  State<NavigationWidget> createState() => _NavigationWidget();
}

class _NavigationWidget extends State<NavigationWidget> {
  int _selectedPage = 0;
  final _widgetOptions = <Widget>[
    const UnauthCardsListWidget(),
    const UnauthProfilWidget(),
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
      backgroundColor: signup_bg, //Color.fromARGB(255, 255, 211, 198),
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
        BottomNavigationBarItem(icon: Icon(Icons.palette), label: 'Товары'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Профиль'),
      ],
      onTap: onSelectedPage,
      ),
    );
  }
}
