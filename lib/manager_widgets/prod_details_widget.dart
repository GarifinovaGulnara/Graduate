// ignore_for_file: must_be_immutable, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/manager_widgets/update_prod_widget.dart';

class ManagerProductDetailsWidget extends StatefulWidget {
  String id_prod;
  String name;
  String? img;
  int price;
  String des;

  ManagerProductDetailsWidget({Key? key, required this.name, required this.des, required this.id_prod, required this.price, this.img}) : super(key: key);

  @override
  _ManagerProductDetailsWidget createState() => _ManagerProductDetailsWidget();
}

class _ManagerProductDetailsWidget extends State<ManagerProductDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: login_bg,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){
            FirebaseFirestore.instance.collection('Products').doc(widget.id_prod).delete();
            Navigator.of(context).pop();
          }, icon: const Icon(Icons.delete)),
          IconButton(onPressed: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context) => UpdateProdWidget(id_prod: widget.id_prod, name: widget.name, des: widget.des, price: widget.price)));
        }, icon: const Icon(Icons.edit))],),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Image.network('${widget.img}', height: MediaQuery.of(context).size.height * 0.3, fit: BoxFit.cover,),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.64,
                    child: Text('${widget.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.04,
                    child: const Text('|', style: TextStyle(fontSize: 36),),),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text('${widget.price} P', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                ],),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('${widget.des}', style: const TextStyle(color: Colors.grey),),),
              SizedBox( height: MediaQuery.of(context).size.height * 0.01,),
              ]
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}