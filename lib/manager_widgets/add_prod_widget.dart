import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

// ignore: must_be_immutable
class AddProdWidget extends StatefulWidget {
  const AddProdWidget({Key? key,}) : super(key: key);

  @override
  _AddProdWidget createState() => _AddProdWidget();
}

class _AddProdWidget extends State<AddProdWidget> {
  TextEditingController nameprod = TextEditingController();
  TextEditingController desprod = TextEditingController();
  TextEditingController priceprod = TextEditingController();
  String idcat ='';
  Color selecteditem = Colors.white;

  int? selectedindex;
  
  final _categStream =
      FirebaseFirestore.instance.collection('Categories').snapshots();

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
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: signup_bg,
      appBar: AppBar(
        backgroundColor: login_bg,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Добавление товара'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /* if(pickedfile != null)
                  Expanded(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.file(File(pickedfile!.path!), width: double.infinity, fit: BoxFit.cover,),
                  ),
                ), */
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                ElevatedButton(onPressed: () async{
                  selectFile();
                }, child: const Text('Добавить картинку'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btn_color)),),
                //add image
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: nameprod,
                  decoration: const InputDecoration(
                  labelText: 'Название товара',
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: desprod,
                  decoration: const InputDecoration(
                  labelText: 'Описание товара',
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: priceprod,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  labelText: 'Цена товара',
                ),),
                const Text('Категория товара',),
                StreamBuilder<QuerySnapshot>(
              stream: _categStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, index) {
                            var docs = snapshot.data!.docs[index];
                            return Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                Container(
                                  color: selectedindex == index ? btn_color : null,
                                  height: MediaQuery.of(context).size.width * 0.12,
                                  child: Card(
                                    child: ListTile(
                                      onTap: (){
                                        idcat = docs.id;
                                        setState(() {
                                          if(selectedindex == index){
                                            selectedindex = null;
                                          }else{
                                            selectedindex = index;
                                          }
                                        });
                                      },
                                      title: Column(
                                        children: [
                                          Text(docs['name'], style: const TextStyle(color: login_bg, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  );
                }
                return const Text('Загрузка данных');
              }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(onPressed: () async{
                    final path = 'ProductImage/${pickedfile!.name}';
                    final file = File(pickedfile!.path!);
                    final ref = FirebaseStorage.instance.ref().child(path);
                    uploadTask = ref.putFile(file);
                    final snapshot = await uploadTask!.whenComplete((){});
                    String downloadUrl = await snapshot.ref.getDownloadURL();
                        FirebaseFirestore.instance.collection('Products').add({"name": nameprod.text, "idcat": idcat, "description": desprod.text, "price": int.parse(priceprod.text), "img": downloadUrl});
                    //message
                    Navigator.of(context).pushReplacementNamed('/main_page');
                  }, child: const Text('Добавить товар'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btn_color)),))
                  
              ]),
          ),
        ),
      ),
    );
  }
}