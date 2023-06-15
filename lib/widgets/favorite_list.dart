import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoriteWidget();
}

class _FavoriteWidget extends State<FavoriteWidget>{

int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: login_bg,
      ), 
      backgroundColor: signup_bg,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<Object>(
              stream: FirebaseFirestore.instance.collection('FavoriteProd').snapshots(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.data == null){
                      return const CircularProgressIndicator();
                    }
                else{
                  var listcart = snapshot.data.docs;
                  return ListView.builder(
                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.18),
                      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index){
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
                                    child: Image.asset("assets/logo.png")),
                                ListTile(
                                  title: Text(
                                        listcart[index]['idprod'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            '${listcart[index]['iduser']}',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }
}