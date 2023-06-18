import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signup_bg,
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Гарифинова Гульнара', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                      color: Colors.white,
                        border: Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(2, 2),
                        )]
                    ),
                child: Column(
                  children: [
                    SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('catalog_page/profil_page/orders_list');
                  }, 
                  child: const Row(
                    children: [
                      Icon(Icons.library_books_outlined), 
                      SizedBox(width: 10,), 
                      Text('Мои заказы')],),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)),
                      ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('catalog_page/profil_page/favorite_list');
                  },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)), 
                  child: const Row(
                    children: [
                      Icon(Icons.favorite),
                      SizedBox(width: 10,), 
                      Text('Избранное')],),
                      ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)), 
                  child: const Row(
                    children: [
                      Icon(Icons.logout_outlined),
                      SizedBox(width: 10,), 
                      Text('Выйти')],),
                      ),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}