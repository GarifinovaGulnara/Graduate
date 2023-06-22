import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

import '../main.dart';

// ignore: must_be_immutable
class PaymentPage extends StatefulWidget {
  String? id_cart;
  int? countProd;
  int? totalsum;
  PaymentPage({Key? key, this.id_cart, this.countProd, this.totalsum}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: signup_bg,
      appBar: AppBar(
        backgroundColor: login_bg,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Оплата корзины'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Имя заказчика:', style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(MyApp.userName,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text('Адрес доставки:', style: TextStyle(fontWeight: FontWeight.bold),),
                  const Text('РТ, г.Казань, ул.Сыртлановой, д.1'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text('Количество товаров: ${widget.countProd} шт.'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text('Общая сумма: ${widget.totalsum} рублей'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text('Заказ будет доставлен в течении 7 дней', style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: ElevatedButton(onPressed: () async{
                      var order = await FirebaseFirestore.instance.collection('Order').add({"iduser": MyApp.idUser, "address": 'РТ, г.Казань, ул.Сыртлановой, д.1', "countitem": widget.countProd, "totalsum": widget.totalsum, "status": "Собирается"});
                      var collection = FirebaseFirestore.instance.collection('Cart');
                      var querySnapshot = await collection.get();
                      for (var queryDocumentSnapshot in querySnapshot.docs) {
                        Map<String, dynamic> data = queryDocumentSnapshot.data();
                        if(data['iduser'] == MyApp.idUser){
                          FirebaseFirestore.instance.collection('Order_cart').add({"idorder": order.id, "idprod": data['idprod']});
                          FirebaseFirestore.instance.collection('Cart').doc(queryDocumentSnapshot.id).delete();
                        }
                      }
                      Navigator.of(context).pushReplacementNamed('catalog_page');
                    }, child: const Text('Оформить'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btn_color)),))
                ]),
            ],
          ),
        ),
      ),
    );
  }
}