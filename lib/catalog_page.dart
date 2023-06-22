import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/widgets/cart_page.dart';
import 'package:graduate_work/widgets/list_cards_categories.dart';
import 'package:graduate_work/widgets/masters_list..dart';
import 'package:graduate_work/widgets/profil_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  int _selectedPage = 0;
  final _widgetOptions = <Widget>[
    const CardsList(),
    const MastersList(),
    const CartPage(),
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: login_bg,
      ), 
      body: Container(child: _widgetOptions[_selectedPage],),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.palette), label: 'Товары'),
        BottomNavigationBarItem(icon: Icon(Icons.photo_camera_back), label: 'Мастер-классы'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_basket), label: 'Корзина'),
        BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Профиль'),
      ],
      onTap: onSelectedPage,
      ),
    );
  }
}
