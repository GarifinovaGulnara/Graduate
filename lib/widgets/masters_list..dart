import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MastersList extends StatefulWidget {
  const MastersList({Key? key}) : super(key: key);

  @override
  State<MastersList> createState() => _MastersListWidgetState();
}

class _MastersListWidgetState extends State<MastersList> {
  
  void onMasDetailTap(){
    Navigator.of(context).pushNamed('/catalog_page/masters_list/masters_class_details');
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: signup_bg,
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('MasterClass').snapshots(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.data == null){
                return const Center(child: CircularProgressIndicator());
              }
              else{
                var listProd = snapshot.data.docs;
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
                        ListTile(
                          title: Text(
                            docs['title'].toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                '${docs['day']}',
                                style: const TextStyle(
                                    color: login_bg,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                'Начало в ${docs['time']}',
                                style: const TextStyle(
                                    color: login_bg,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                '${docs['address']}',
                                style: const TextStyle(
                                    color: login_bg,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.01,
                              ),
                              Text(
                                docs['description'],
                                maxLines: 20,
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
            }));
  }
}