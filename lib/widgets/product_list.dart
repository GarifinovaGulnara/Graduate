// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/widgets/prod_details.dart';

class ProductListWidget extends StatefulWidget {
  dynamic id_cat;
  ProductListWidget({Key? key, this.id_cat}) : super(key: key);

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: login_bg,
        appBar: AppBar(
          title: const Text('ХоббиМаркет'),
          centerTitle: true,
          backgroundColor: signup_bg,
          foregroundColor: Colors.white,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('Products').snapshots(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.data == null){
                return const CircularProgressIndicator();
              }
              else{
                  var listProd = snapshot.data.docs.where((x)=>x['idcat']==widget.id_cat).toList();
                return ListView.builder(
                itemCount: listProd.length,
                itemBuilder: (context, index) {
                  if(!snapshot.hasData)
                  {
                    return const Center(
                      child: Text('Нет данных'),
                    );
                  } else{
                    return Card(
                    child: InkWell(
                      onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductDetails(id_prod: listProd[index]['idprod'], name: listProd[index]['name'], des: listProd[index]['description'], price: listProd[index]['price']))),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.20,
                              child: Image.asset("assets/logo.png")),
                          ListTile(
                            title: Text(
                              listProd[index]['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${listProd[index]['price']} P',
                                  style: const TextStyle(
                                      color: btn_color,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  listProd[index]['description'],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  }
                },
              );
              }
            }));
  }
}
