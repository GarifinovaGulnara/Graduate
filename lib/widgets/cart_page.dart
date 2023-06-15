import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>{

int count = 1;
  void onPayTap(){
    Navigator.pushNamed(context, '/auth/catalog_page/cart_page/payment_page');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signup_bg,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<Object>(
              stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.data == null){
                      return const CircularProgressIndicator();
                    }
                else{
                  var listcart = snapshot.data.docs;
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.18),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index){
                      if(!snapshot.hasData){
                        return const Center(
                            child: Text('Нет данных'),
                          );
                      }else{
                        return Card(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    child: Image.asset("assets/logo.png")),
                                ListTile(
                                  title: Text(
                                        listcart[index]['idprod'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${listcart[index]['totalsum']} P',
                                            style: const TextStyle(
                                                color: btn_color,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.01,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.1,
                                          ),
                                              /* Padding(
                                                padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        IconButton(onPressed: (){
                                                          print('minus');
                                                        }, icon: const Icon(Icons.remove_circle_outline),),
                                                        Text('${listcart[index]['count']}'),
                                                        IconButton(onPressed: (){
                                                          print('plus');
                                                        }, icon: const Icon(Icons.add_circle_outline),),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                      child: OutlinedButton(onPressed: (){}, child: const Text('Подробнее'), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(btn_color)),))
                                                  ],
                                                ),
                                              ), */
                                      ],
                                    ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                      }
                    },
                    );
                }
              }
            ),
          ),
              /* Expanded(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.67),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Всего товаров:'),
                                Text('5'),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Общая сумма:'),
                                Text('1200 руб.'),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                  height: 40,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: onPayTap, 
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(btn_color),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                    child: const Text('Оформить заказ'),))
                          ],
                        ),),
                      ),
                  )
                ]),
              ), */
        ],
      ),
    );
  }
}