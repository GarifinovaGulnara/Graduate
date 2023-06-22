// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/main.dart';

class ProductDetails extends StatefulWidget {
  String? id_prod;
  String? name;
  String? img;
  int? price;
  String? des;

  ProductDetails({Key? key, this.name, this.des, this.id_prod, this.price, this.img}) : super(key: key);
  
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Color colorfav = login_bg;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: colorfav,
        backgroundColor: Colors.transparent,
        /* actions: [
          IconButton(onPressed: (){
            if( colorfav == login_bg){
              setState(() {
                FirebaseFirestore.instance.collection('FavoriteProd').add({"iduser": MyApp.idUser, "idprod": widget.id_prod});
                colorfav = Colors.red;
              });
            }else {
              setState(() async {
                var collection = FirebaseFirestore.instance.collection('FavoriteProd');
                var querySnapshot = await collection.get();
                collection.doc(widget.id_prod).delete();
                var list = querySnapshot.docs.where((x)=>x['iduser']== MyApp.idUser ? true : false).toList();
                colorfav = login_bg;
              });
            }
          }, icon: Icon(Icons.favorite))
        ], */
        ),
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
                    width: MediaQuery.of(context).size.width * 0.63,
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
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: (){
                    FirebaseFirestore.instance.collection('Cart').add({'totalsum': widget.price, 'idprod': widget.id_prod, 'iduser': MyApp.idUser});
                  }, 
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(btn_color),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                  ),
                  child: const Text('Добавить в корзину'),))
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