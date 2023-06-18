import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class UnauthProfilWidget extends StatelessWidget {
  const UnauthProfilWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signup_bg,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Необходимо авторизоваться', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btn_color)),
            onPressed: (){ 
            Navigator.of(context).pushNamed('/auth');}, 
          child: const Text('Авторизоваться')),
          
        ],
      )),
    );
  }
}