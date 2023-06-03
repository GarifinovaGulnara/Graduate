import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);
  
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(234, 253, 251, 251),
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.favorite))],),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Image.asset("assets/logo.png", height: MediaQuery.of(context).size.height * 0.3, fit: BoxFit.cover,),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: const [
                  Expanded(
                    child: Text('Name Product', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
                  Text('Price', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                ],),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text('Description prod in English, but need in Russian and something. Description prod in English, but need in Russian Description prod in English, but need in Russian', style: TextStyle(color: Colors.grey),),),
              SizedBox( height: MediaQuery.of(context).size.height * 0.01,),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  onPressed: (){
                    FirebaseFirestore.instance.collection('Cart').add({'Count': 1});
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