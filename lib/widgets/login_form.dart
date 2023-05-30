import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
                decoration: const InputDecoration(
                  hintText: "Телефон",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defpaultPadding),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Пароль",
                ),
              ),
            ),
            OutlinedButton(onPressed: (){
              Navigator.of(context).pushReplacementNamed('/catalog_page');
            }, 
            child: const Text('Войти'), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white),),)
          ],
        ),
        ),
      );
  }
}