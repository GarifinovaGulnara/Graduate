import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

// ignore: must_be_immutable
class UpdateProdWidget extends StatefulWidget {
  String id_prod;
  String name;
  String des;
  int price;
  UpdateProdWidget({Key? key, required this.id_prod, required this.name, required this.des, required this.price}) : super(key: key);

  @override
  _UpdateProdWidget createState() => _UpdateProdWidget();
}

class _UpdateProdWidget extends State<UpdateProdWidget> {
  TextEditingController nameprod = TextEditingController();
  TextEditingController desprod = TextEditingController();
  TextEditingController priceprod = TextEditingController();
  
  @override 
  void initState(){
    super.initState();
    nameprod.text = widget.name;
    desprod.text = widget.des;
    priceprod.text = widget.price.toString();
    setState(() {
      
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
        title: const Text('Изменение товара'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                maxLines: 10,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(onPressed: () async{
                  var collection = FirebaseFirestore.instance.collection('Products');
                  var querySnapshot = await collection.get();
                  for (var queryDocumentSnapshot in querySnapshot.docs) {
                    if(queryDocumentSnapshot.id == widget.id_prod)
                    {
                      FirebaseFirestore.instance.collection('Products').doc(widget.id_prod).update({"name": nameprod.text, "description": desprod.text, "price": int.parse(priceprod.text)});
                    }
                  }
                  //message
                  Navigator.of(context).pushNamed('/main_page');
                }, child: const Text('Сохранить изменения'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btn_color)),))
            ]),
        ),
      ),
    );
  }
}