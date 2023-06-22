import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/main.dart';
import 'package:graduate_work/widgets/payment_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class newClass
{
  late String idItem;
  late String name;
  late String img;

  newClass(String x, String y, String z) {
    idItem = x;
    name = y;
    img = z;
  }
}

class _CartPageState extends State<CartPage>{

Future<void> TakeUp()
async {
    var collection = FirebaseFirestore.instance.collection('Cart');
    var querySnapshot = await collection.get();
    var list = querySnapshot.docs.where((x)=>x['iduser']== MyApp.idUser ? true : false).toList();
    countItem = list.length;
    setState(() {
          
    });
}

Future<void> TakeTotalSum()
async {
    var collection = FirebaseFirestore.instance.collection('Cart');
    var querySnapshot = await collection.get();
    var list = querySnapshot.docs.where((x)=>x['iduser']== MyApp.idUser ? true : false).toList();
    for (var queryDocumentSnapshot in list) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var sum = data['totalsum'].toString();
      totalsum += int.parse(sum);
    }
    setState(() {
          
    });
}

Future<void> MinusTotalSum(int sum)
async {
    totalsum -= sum;
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
      var img = data['img'].toString();
        itemName.add(newClass(idItem, name, img));
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
    TakeUp();
    TakeTotalSum();
  }

List<newClass> itemName = []; 
int countItem = 0; 
int totalsum = 0; 
String idcart = '';
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
                  var list = snapshot.data.docs.where((x)=>x['iduser']== MyApp.idUser ? true : false).toList();
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index){
                        var listcart = list[index];
                        idcart = listcart.id;
                      if(!snapshot.hasData){
                        return const Center(
                            child: Text('Нет данных'),
                          );
                      }else{
                        return Card(
                        child: Stack(
                          children: [
                            ListTile(
                              onTap: () {
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(
                                      title: const Text('Вы действительно хотите удалить товар?', style: TextStyle(color: login_bg),),
                                      actions: [
                                        ElevatedButton(onPressed: (){
                                          Navigator.of(context).pop();
                                        }, child: const Text('Нет'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(btn_color)),),
                                        SizedBox( width: MediaQuery.of(context).size.width * 0.04,),
                                        OutlinedButton(onPressed: (){
                                          FirebaseFirestore.instance.collection('Cart').doc(listcart.id).delete();
                                          TakeUp();
                                          MinusTotalSum(listcart['totalsum']);
                                          Navigator.of(context).pop();
                                        }, 
                                        child: const Text('Да'), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(login_bg))),
                                      ],
                                    );
                                });
                              },
                              title: Column(
                                children: [
                                  SizedBox(
                                height: MediaQuery.of(context).size.height * 0.03,
                                //child: Image.network('img')
                                ),
                               Text(
                                    GetProfuctName(listcart['idprod']),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                              Row(
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
                                ],
                              ),
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
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.65),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.17,
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
                                const Text('Всего товаров:'),
                                Text('${countItem}'),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text('Общая сумма:'),
                                Text('${totalsum} рублей'),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            SizedBox(
                  height: 40,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: (){
                       Navigator.push(context, CupertinoPageRoute(builder: (context) => PaymentPage(id_cart: idcart, countProd: countItem, totalsum: totalsum, )));
                    }, 
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