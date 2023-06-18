import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidget();
}

class _OrdersWidget extends State<OrdersWidget>{

int count = 1;
  void onPayTap(){
    Navigator.pushNamed(context, '/auth/catalog_page/cart_page/payment_page');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заказы'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: login_bg,
      ), 
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
                  
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.18),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index){
                        var listcart = snapshot.data.docs[index];
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
                                        listcart['idprod'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${listcart['totalsum']} P',
                                            style: const TextStyle(
                                                color: btn_color,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            'Заказ собирается',
                                            style: TextStyle(
                                                color: btn_color,
                                                fontWeight: FontWeight.bold),
                                          ),
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
        ],
      ),
    );
  }
}