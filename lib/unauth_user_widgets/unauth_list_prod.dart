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
  
  TextEditingController searchController = TextEditingController();
  bool search = false;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    AppBar appBarSearch = AppBar(
    centerTitle: true,
    title: TextField(
      onChanged: (value) {
        setState(() {
        searchText = value;
        });
      },
      controller: searchController,
    ),
    backgroundColor: login_bg,
          foregroundColor: Colors.white,
          actions: [IconButton(onPressed: (){
            setState(() {
              search = !search;
              searchController.clear();
              searchText = '';
            });
          }, icon: const Icon(Icons.exit_to_app))],
  );
  AppBar appBar = AppBar(
    title: const Text('ХоббиМаркет'),
          centerTitle: true,
          backgroundColor: login_bg,
          foregroundColor: Colors.white,
          actions: [IconButton(onPressed: (){
            setState(() {
              search = !search;
            });
          }, icon: const Icon(Icons.search))],
  );
    return Scaffold(
      backgroundColor: signup_bg,
        appBar: search? appBarSearch : appBar,
        body: Stack(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('Products').snapshots(),
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.data == null){
                    return const Center(child: CircularProgressIndicator());
                  }
                  else{
                    var listProd = snapshot.data.docs.where((x)=>x['idcat']==widget.id_cat && x['name'].contains(searchText) ? true : false).toList();
                  
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
                        child: InkWell(
                          onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => UnauthProductDetailsWidget(id_prod: docs.id, name: docs['name'], des: docs['description'], price: docs['price'], img: docs['img'],))),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.20,
                                  child: Image.network(docs['img'])),
                              ListTile(
                                title: Text(
                                  docs['name'].toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${docs['price']} P',
                                      style: const TextStyle(
                                          color: btn_color,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.01,
                                    ),
                                    Text(
                                      docs['description'],
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
          /* Padding(
          padding: const EdgeInsets.all(18),
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),
        ), */
          ],
        ));
  }
}
