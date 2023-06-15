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
                var docs = snapshot.data!.docs;
                return ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemExtent: MediaQuery.of(context).size.height * 0.25,
                    itemCount: docs.length,
                    itemBuilder: (BuildContext context, index) {
                      return Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ProductListWidget(id_cat: docs[index].id,))),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                          child: SizedBox(
                                            height: MediaQuery.of(context).size.height * 0.14,
                                            child: Image.asset("assets/logo.png")),
                                        ),
                                        Center(
                                          child: ListTile(
                                            title: Text(docs[index]['name'], style: const TextStyle(color: login_bg, fontWeight: FontWeight.bold),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              }
              return const Text('Загрузка данных');
            }),
      ],
    );
  }
}
