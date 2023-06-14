import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LogupForm extends StatefulWidget {
  const LogupForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LogupForm> createState() => _LogupFormState();
}

class _LogupFormState extends State<LogupForm> {

  final controllerName = TextEditingController();
  final controllerPhone = TextEditingController();
  final controllerPass = TextEditingController();


  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
  @override
  void initState(){
    super.initState();
    initFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.13),
      child: Form(
        child: Column(
          children: [
            const Spacer(),
            TextFormField(
              controller: controllerName,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  hintText: "Фамилия Имя",
              ),
              //onChanged: (value) => name = value,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defpaultPadding),
              child: TextFormField(
                controller: controllerPhone,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Телефон",
                ),
              ),
            ),
            TextFormField(
              controller: controllerPass,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Пароль",
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
            OutlinedButton(onPressed: (){
              FirebaseFirestore.instance.collection('Users').add({'Name': controllerName.text, 'Login': controllerPhone.text, 'Password': controllerPass.text});
            }, 
              child: const Text('Зарегистрироваться'), 
              style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.white)),),
            const Spacer(flex: 1,)
          ],
        ),
        ),
      );
  }
}