// ignore_for_file: must_be_immutable, unused_local_variable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/main.dart';

class FavoriteListWidget extends StatefulWidget {
  FavoriteListWidget({Key? key,}) : super(key: key);

  @override
  State<FavoriteListWidget> createState() => _FavoriteListWidget();
}

class newClass
{
  late String idItem;
  late String name;
  late int price;
  late String des;
  late String img;

  newClass(String x, String y, int z, String w, String i) {
    idItem = x;
    name = y;
    price = z;
    des = w;
    img = i;
  }
}
class _FavoriteListWidget extends State<FavoriteListWidget> {

Future<void> TakeNameProduct()
async {
    var collection = FirebaseFirestore.instance.collection('Products');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      var idItem = queryDocumentSnapshot.id;
      var name = data['name'].toString();
      var price = data['price'].toString();
      var des = data['description'].toString();
      var img = data['img'];
        itemName.add(newClass(idItem, name, int.parse(price), des, img));
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

String GetProfuctPrice(String id)
{
  for (var item in itemName) {
    if(item.idItem == id)
      {
        return item.price.toString();
      }
  }
  return 'не нашлась ${id}';
}

String GetProfuctDes(String id)
{
  for (var item in itemName) {
    if(item.idItem == id)
      {
        return item.des;
      }
  }
  return 'не нашлась ${id}';
}

String GetProfuctImg(String id)
{
  for (var item in itemName) {
    if(item.idItem == id)
      {
        return item.img;
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
      backgroundColor: signup_bg,
        appBar: AppBar(
          title: const Text('Избранное'),
          centerTitle: true,
          backgroundColor: login_bg,
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('FavoriteProd').snapshots(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.data == null){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else{
                    var listProd = snapshot.data.docs.where((x)=>x['iduser'] == MyApp.idUser ? true : false).toList();

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                    itemCount: listProd.length,
                    itemBuilder: (context, index) {
                      var docs = listProd[index];
                      if(!snapshot.hasData)
                      {
                        return const Center(
                          child: Text('Нет данных'),
                        );
                      } else{
                        return Card(
                        child: Column(
                          children: [
                            /* SizedBox(
                                height: MediaQuery.of(context).size.height * 0.20,
                                child: Image.network(GetProfuctImg(docs['idprod']))), */
                            ListTile(
                              title: Text(
                                docs.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    docs.name,
                                    style: const TextStyle(
                                        color: btn_color,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  Text(
                                    docs.name,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
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
                }),
          ],
        ));
  }
}
