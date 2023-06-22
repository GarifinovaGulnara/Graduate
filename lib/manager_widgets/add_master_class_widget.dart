import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

// ignore: must_be_immutable
class AddMasterClassWidget extends StatefulWidget {
  const AddMasterClassWidget({Key? key,}) : super(key: key);

  @override
  _AddMasterClassWidget createState() => _AddMasterClassWidget();
}

class _AddMasterClassWidget extends State<AddMasterClassWidget> {
  TextEditingController title = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController timestart = TextEditingController();
  TextEditingController address = TextEditingController();
  String idcat ='';
  Color selecteditem = Colors.white;

  int? selectedindex;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: signup_bg,
      appBar: AppBar(
        backgroundColor: login_bg,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Добавление мастер-класса'),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                  labelText: 'Название мастер-класса:',
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: des,
                  maxLines: 5,
                  decoration: const InputDecoration(
                  labelText: 'Описание мастер-класса:',
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: address,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  labelText: 'Место проведения:',
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: day,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  labelText: 'Дата:',
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextField(
                  controller: timestart,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                  labelText: 'Время начала:',
                ),),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(onPressed: (){
                        FirebaseFirestore.instance.collection('MasterClass').add({"title": title.text, "address": address.text, "description": des.text, "time": timestart.text, "day": day.text});
                    //message
                    Navigator.of(context).pushReplacementNamed('/main_page');
                  }, child: const Text('Добавить мастре-класс'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btn_color)),)),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02,)
                  
              ]),
          ),
        ),
      ),
    );
  }
}