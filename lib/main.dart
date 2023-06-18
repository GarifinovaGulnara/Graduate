import 'package:flutter/material.dart';
import 'package:graduate_work/authorization.dart';
import 'package:graduate_work/catalog_page.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/payment_page.dart';
import 'package:graduate_work/prod_details.dart';
import 'package:graduate_work/widgets/cart_page.dart';
import 'package:graduate_work/widgets/masters_list..dart';
import 'package:graduate_work/widgets/profil_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static String UserName = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
          filled: true,
          fillColor: const Color.fromARGB(255, 254, 254, 254),
          hintStyle: TextStyle(color: Colors.grey[500]),
          contentPadding: const EdgeInsets.symmetric(
            vertical: defpaultPadding * 1.2, horizontal: defpaultPadding
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: login_bg,
          unselectedItemColor: signup_bg,
        ),
      ),
      routes: {
        '/':(context) => const AuthorizationPage(),
        '/catalog_page':(context) => const CatalogPage(),
        '/catalog_page/product_list/prod_details':(context) => const ProductDetails(),
        '/catalog_page/masters_list':(context) => const MastersList(),
        '/catalog_page/profil_page':(context) => const ProfilPage(),
        '/catalog_page/cart_page':(context) => const CartPage(),
        '/catalog_page/cart_page/payment_page':(context) => const PaymentPage(),
      },
      initialRoute: '/',
    );
  }
}
