import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

import '../main.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);


  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool state = false;
  bool ismanager = false;
  final controllerPhone = TextEditingController();
  final controllerPass = TextEditingController();

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
              controller: controllerPhone,
              keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Телефон",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defpaultPadding),
              child: TextFormField(
                controller: controllerPass,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Пароль",
                ),
              ),
            ),
            OutlinedButton(onPressed: () async {
              if(await UserExist()){
                state = false;
                if(ismanager == false){
                  Navigator.of(context).pushReplacementNamed('catalog_page');
                }
                else{
                  Navigator.of(context).pushReplacementNamed('/main_page');
                }
              }
              else{
                setState(() {
                  state = true;
                });
              }
            }, 
            child: const Text('Войти'), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white),),),
            Text(state ? 'Ошибка. Аккаунт не найден. Проверьте логин/пароль': '', style: const TextStyle(color: Colors.white),),
          ],
        ),
        ),
      );
  }

  Future<bool> UserExist() async
  {
    var collection = FirebaseFirestore.instance.collection('Users');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var phone = data['login'];
      var pass = data['password'];
      ismanager = data['is_manager'];
      if(phone == controllerPhone.text)
      {
        if(pass == controllerPass.text)
        {
          MyApp.userName = data['name'];
          MyApp.idUser = queryDocumentSnapshot.id;
          return true;
        }
      }
    }

    return false;
  }
}