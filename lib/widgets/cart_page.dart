import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class newClass
{
  late String idItem;
  late String name;

  newClass(String x, String y) {
    // See initializing formal parameters for a better way
    // to initialize instance variables.
    idItem = x;
    name = y;
  }
}

class _CartPageState extends State<CartPage>{

Future<void> TakeUp()
async {
    var collection = FirebaseFirestore.instance.collection('Cart');
    var querySnapshot = await collection.get();
    countItem = querySnapshot.docs.length;
    setState(() {
          
    });
}

Future<void> TakeTotalSum()
async {
    var collection = FirebaseFirestore.instance.collection('Cart');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var sum = data['totalsum'].toString();
      totalsum += int.parse(sum);
    }
    setState(() {
          
    });
}

Future<void> TakeNameProduct()
async {
    var collection = FirebaseFirestore.instance.collection('Products');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var idItem = queryDocumentSnapshot.id;
      var name = data['name'].toString();
      // if (idItem == id){
        itemName.add(newClass(idItem, name));
      //   break;
      // }
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
    // TODO: implement initState
    super.initState();
    TakeUp();
    TakeTotalSum();
  }

List<newClass> itemName = []; 
int countItem = 0; 
int totalsum = 0; 
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
                  // TakeNameProduct();

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
                                    //child: Image.network(listcart['img'])
                                    ),
                                ListTile(
                                  title: Text(
                                        GetProfuctName(listcart['idprod']),
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
                                          SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.01,
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.1,
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
              Expanded(
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.67),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Всего товаров:'),
                                Text('${countItem}'),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Общая сумма:'),
                                Text('${totalsum} руб.'),
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
              ),
        ],
      ),
    );
  }
}