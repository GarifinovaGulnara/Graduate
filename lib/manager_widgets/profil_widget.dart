import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/main.dart';

class ProfilWidget extends StatefulWidget {
  ProfilWidget({Key? key}) : super(key: key);

  @override
  State<ProfilWidget> createState() => _ProfilWidgetState();
}

class _ProfilWidgetState extends State<ProfilWidget> {
  TextEditingController nameCat = TextEditingController();

  PlatformFile? pickedfile;

UploadTask? uploadTask;

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if(result == null)
    {
      return;
    }
    setState(() {
      pickedfile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signup_bg,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(MyApp.userName, style: const TextStyle(color: Colors.white, fontSize: 18),),
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
                    Navigator.of(context).pushNamed('/main_page/profil_widget/all_orders_list');
                  }, 
                  child: const Row(
                    children: [
                      Icon(Icons.library_books_outlined), 
                      SizedBox(width: 10,), 
                      Text('Заказы')],),
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)),
                      ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/main_page/profil_widget/add_master_class_widget');
                  },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)), 
                  child: const Row(
                    children: [
                      Icon(Icons.add_circle_rounded),
                      SizedBox(width: 10,), 
                      Text('Добавить мастер-класс')],),
                      ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).pushNamed('/main_page/profil_widget/add_prod_widget');
                  },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)), 
                  child: const Row(
                    children: [
                      Icon(Icons.add_circle_rounded),
                      SizedBox(width: 10,), 
                      Text('Добавить товар')],),
                      ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                      SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: (){
                    showDialog(context: context, builder: (context) {
                      return AlertDialog(
                      title: const Text('Добавление категории', style: TextStyle(color: login_bg),),
                        actions: [
                          TextField(
                          controller: nameCat,
                          decoration: const InputDecoration(
                            hintText: 'Название категории'
                            ),
                          ),
                          OutlinedButton(onPressed: (){
                            selectFile();
                          }, child: Text('Добавить картинку'), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(login_bg)),),

                          SizedBox( width: MediaQuery.of(context).size.width * 0.04,),
                          
                          OutlinedButton(onPressed: () async {
                            final path = 'ProductImage/${pickedfile!.name}';
                            final file = File(pickedfile!.path!);
                            final ref = FirebaseStorage.instance.ref().child(path);
                            uploadTask = ref.putFile(file);
                            final snapshot = await uploadTask!.whenComplete((){});
                            String downloadUrl = await snapshot.ref.getDownloadURL();
                            FirebaseFirestore.instance.collection('Categories').add({"name": nameCat.text, "img": downloadUrl});
                            Navigator.of(context).pop();
                            nameCat.clear();
                            }, 
                            child: const Text('Добавить'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg), foregroundColor: MaterialStateProperty.all(Colors.white))),
                          ],
                        );
                     });
                  },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(login_bg)), 
                  child: const Row(
                    children: [
                      Icon(Icons.add_circle_outline),
                      SizedBox(width: 10,), 
                      Text('Добавить категорию')],),
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