import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class AllOrdersWidget extends StatefulWidget {
  const AllOrdersWidget({Key? key}) : super(key: key);

  @override
  State<AllOrdersWidget> createState() => _AllOrdersWidget();
}

class _AllOrdersWidget extends State<AllOrdersWidget>{

int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заказы'),
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
                  var listcart = snapshot.data.docs;
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.18),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: listcart.length,
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