import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduate_work/constants.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>{

  void onPayTap(){
    Navigator.pushNamed(context, '/catalog_page/cart_page/payment_page');
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.18),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: 5,
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
                        onTap: (){},
                      ),
                    )
                  ],
                ),
              );
            },
            ),
            Expanded(
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.67),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text('Всего товаров:'),
                              Text('fhanfakhv'),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text('Общая сумма:'),
                              Text('fhanfakhv'),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          SizedBox(
                height: 40,
                width: 180,
                child: ElevatedButton(
                  onPressed: onPayTap, 
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(btn_color),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                  child: const Text('Оплатить'),))
                        ],
                      ),),
                    ),
                )
              ]),
            ),
      ],
    );
  }
}