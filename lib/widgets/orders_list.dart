import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/main.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  State<OrdersWidget> createState() => _OrdersWidget();
}
class newClass
{
  late String idItem;
  late String name;
  late int price;

  newClass(String x, String y, int z) {
    idItem = x;
    name = y;
    price = z;
  }
}

class _OrdersWidget extends State<OrdersWidget>{

Future<void> TakeNameProduct()
async {
    var collection = FirebaseFirestore.instance.collection('Products');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var idItem = queryDocumentSnapshot.id;
      var name = data['name'].toString();
      var price = data['price'].toString();
        itemName.add(newClass(idItem, name, int.parse(price)));
    }
}

String GetProfuctName(String id)
{
  for (var item in itemName) {
    if(item.idItem == id)
      {
        return item.name;
      }
  }
  return 'не нашлась ${id}';
}

@override
void initState() {
    TakeNameProduct();
    super.initState();
  }

List<newClass> itemName = []; 

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
              stream: FirebaseFirestore.instance.collection('Order').snapshots(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.data == null){
                      return const CircularProgressIndicator();
                    }
                else{
                  var list = snapshot.data.docs.where((x)=>x['iduser']== MyApp.idUser ? true : false).toList();
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.18),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index){
                        var listcart = list[index];
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
                                ListTile(
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