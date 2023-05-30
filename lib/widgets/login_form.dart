import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool state = false;
  String names = '';
  String passss = '';

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
              onChanged: (value) => names = value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defpaultPadding),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Пароль",
                ),
                onChanged: (value) => passss = value,
              ),
            ),
            OutlinedButton(onPressed: () async {
              if(await UserExist()){
                state = false;
                Navigator.of(context).pushReplacementNamed('/catalog_page');
              }
              else{
                setState(() {
                  state = true;
                });
              }
            }, 
            child: const Text('Войти'), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white),),),
            Text(state ? 'Error': ''), 
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
      var name = data['Login'];
      var phone = data['Name'];
      var pass = data['Password'];
      if(name == names)
      {
        if(pass == passss)
        {
          return true;
        }
      }
    }

    return false;
  }
}