import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: signup_bg,
      appBar: AppBar(
        backgroundColor: login_bg,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Оплата корзины'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('widget.nameUser',),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text('address'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text('widget.count'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text('widget.totalsum'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text('Заказ будет доставлен в течении 7 дней'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: OutlinedButton(onPressed: (){}, child: const Text('Оформить'), style: ButtonStyle(foregroundColor: MaterialStateProperty.all(btn_color)),))
                ]),
            ],
          ),
        ),
      ),
    );
  }
}