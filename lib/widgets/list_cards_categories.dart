import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/widgets/product_list.dart';

import '../constants.dart';

class CardsList extends StatefulWidget {
  const CardsList({Key? key}) : super(key: key);
  @override
  State<CardsList> createState() => _CardsList();
}

class _CardsList extends State<CardsList> {
  final _categStream =
      FirebaseFirestore.instance.collection('Categories').snapshots();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: _categStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, index) {
                          var docs = snapshot.data!.docs[index];
                          return Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.width * 0.45,
                                child: Card(
                                  child: ListTile(
                                    onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductListWidget(id_cat: docs.id,))),
                                    title: Column(
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.14,
                                          child: Image.network(docs['img'])),
                                        Text(docs['name'], style: const TextStyle(color: login_bg, fontWeight: FontWeight.bold),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                );
              }
              return const Text('Загрузка данных');
            }),
      ],
    );
  }
}
