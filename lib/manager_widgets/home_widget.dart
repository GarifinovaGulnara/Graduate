import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

import 'list_prod_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);
  @override
  State<HomeWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<HomeWidget> {
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
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: Expanded(
                                  child: InkWell(
                                    onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => ManagerProductListWidget(id_cat: docs[index].id,))),
                                    child: Column(
                                      children: [
                                        Center(
                                          child: ListTile(
                                            title: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                                                  child: SizedBox(
                                                    height: MediaQuery.of(context).size.height * 0.14,
                                                    child: Image.asset("assets/logo.png")),
                                                ),
                                                Text(docs[index]['name'], style: const TextStyle(color: login_bg, fontWeight: FontWeight.bold),),
                                              ],
                                            ),
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
