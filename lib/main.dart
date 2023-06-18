import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/authorization.dart';
import 'package:graduate_work/catalog_page.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/widgets/payment_page.dart';
import 'package:graduate_work/widgets/prod_details.dart';
import 'package:graduate_work/unauth_user_widgets/navigation_page.dart';
import 'package:graduate_work/widgets/favorite_list.dart';
import 'package:graduate_work/widgets/orders_list.dart';
import 'package:graduate_work/widgets/product_list.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/':(context) => const NavigationWidget(),
        '/auth':(context) => const AuthorizationPage(),
        'catalog_page':(context) => const CatalogPage(),
        'catalog_page/list_cards_categories/product_list':(context) => ProductListWidget(),
        'catalog_page/list_cards_categories/product_list/prod_details':(context) => ProductDetails(),
        'catalog_page/cart_page/payment_page':(context) => const PaymentPage(),
        'catalog_page/profil_page/orders_list':(context) => const OrdersWidget(),
        'catalog_page/profil_page/favorite_list':(context) => const FavoriteWidget(),
      },
      initialRoute: '/',
    );
  }
}
