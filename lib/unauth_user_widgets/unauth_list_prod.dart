// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/unauth_user_widgets/unauth_prod_details.dart';

class UnauthProductListWidget extends StatefulWidget {
  dynamic id_cat;
  UnauthProductListWidget({Key? key, this.id_cat}) : super(key: key);

  @override
  State<UnauthProductListWidget> createState() => _UnauthProductListWidget();
}

class _UnauthProductListWidget extends State<UnauthProductListWidget> {
  
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: signup_bg,
        appBar: AppBar(
          title: const Text('ХоббиМаркет'),
          centerTitle: true,
          backgroundColor: login_bg,
          foregroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance.collection('Products').snapshots(),
                  builder: (context, AsyncSnapshot<dynamic> snapshot) {
                    if(snapshot.data == null){
                      return const Center(child: CircularProgressIndicator());
                    }
                    else{
                       var listProd = snapshot.data.docs.where((x)=>x['idcat']==widget.id_cat).toList();
                      if(_searchController.text.isNotEmpty){
                        listProd = listProd.where((x)=>x['idcat']==widget.id_cat && x['name'.toLowerCase()].contains(_searchController.text.toLowerCase())).toList();
                      }else{listProd;}
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
                            onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => UnauthProductDetailsWidget(id_prod: listProd[index]['idprod'], name: listProd[index]['name'], des: listProd[index]['description'], price: listProd[index]['price']))),
                            child: Column(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.20,
                                    child: Image.asset("assets/logo.png")),
                                ListTile(
                                  title: Text(
                                    listProd[index]['name'].toString(),
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
                  }),
            ),
          Padding(
          padding: const EdgeInsets.all(18),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),
        ),
          ],
        ));
  }
}
