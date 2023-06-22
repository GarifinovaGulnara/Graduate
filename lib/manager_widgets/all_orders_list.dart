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
              stream: FirebaseFirestore.instance.collection('Order').snapshots(),
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
                        var listcart = snapshot.data!.docs[index];
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
                                /* SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.15,
                                    child: Image.asset("assets/logo.png")), */
                                ListTile(
                                  onTap: () {
                                showDialog(context: context, builder: (context) {
                                  return Container(
                                    child: AlertDialog(
                                      title: const Text('Изменить статус заказа', style: TextStyle(color: login_bg),),
                                      actions: [
                                        Column(

                                          children: [
                                            OutlinedButton(onPressed: (){
                                              FirebaseFirestore.instance.collection('Order').doc(listcart.id).update({"status": "Собирается"});
                                          Navigator.of(context).pop();
                                        }, child: const Text('Собирается'),),
                                        SizedBox( width: MediaQuery.of(context).size.width * 0.04,),
                                        OutlinedButton(onPressed: (){
                                          FirebaseFirestore.instance.collection('Order').doc(listcart.id).update({"status": "Можно забирать"});
                                          Navigator.of(context).pop();
                                        }, 
                                        child: const Text('Можно забирать')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                                  title: Text(
                                        "Код заказа: ${listcart.id}",
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
                                          Text(
                                            '${listcart['status']}',
                                            style: const TextStyle(
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