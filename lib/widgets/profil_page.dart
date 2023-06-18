import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/main.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signup_bg,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Image.asset("assets/logo.png"),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(MyApp.UserName, style: const TextStyle(color: Colors.white, fontSize: 18),),
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
                  onPressed: (){}, 
                  child: Row(
                    children: const [
                      Icon(Icons.favorite), 
                      SizedBox(width: 10,), 
                      Text('Избранное')],),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)),
                      ),
                      ),
                      const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: (){},
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)), 
                  child: Row(
                    children: const [
                      Icon(Icons.library_books_outlined),
                      SizedBox(width: 10,), 
                      Text('Мои заказы')],),
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