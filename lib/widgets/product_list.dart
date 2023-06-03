import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {

  void onProdTap(){
    Navigator.of(context).pushNamed('/catalog_page/product_list/prod_details');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: 10,
          itemExtent: 100,
          itemBuilder: (BuildContext context, int index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                      border: Border.all(color: Colors.black.withOpacity(0.2)),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )]
                  ),
                  clipBehavior: Clip.hardEdge,
                  child:  Row(
                      children: [
                        Image.asset("assets/logo.png"),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              SizedBox(height: 10),
                              Text('Name', maxLines: 1, overflow: TextOverflow.ellipsis,),
                              SizedBox(height: 5,),
                              Text('Des', style: TextStyle(color: Colors.grey, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis,),
                              Text('Price', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: onProdTap,
                  ),
                )
              ],
            ),
          );
        },
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Поиск',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}