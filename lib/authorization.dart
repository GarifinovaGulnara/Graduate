import 'dart:math';
import 'package:flutter/material.dart';
import 'package:graduate_work/constants.dart';
import 'package:graduate_work/widgets/login_form.dart';
import 'package:graduate_work/widgets/logup_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}
class _AuthorizationPageState extends State<AuthorizationPage>
  with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation(){
    _animationController = AnimationController(vsync: this, duration: defaultDuration);
    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void updateView(){
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp ? _animationController.forward(): _animationController.reverse();
  }

  @override
  void initState()
  {
    setUpAnimation();
    //initFirebase();
    super.initState();
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(children: [
            AnimatedPositioned(
              duration: defaultDuration,
              width: _size.width * 0.88,
              height: _size.height,
              left: _isShowSignUp ? -_size.width * 0.76 : 0,
              child: Container(
                color: login_bg,
                child: const LoginForm(),
              ),
            ),
            AnimatedPositioned(
              duration: defaultDuration,
              width: _size.width * 0.88,
              height: _size.height,
              left: _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
              child: Container(
                color: signup_bg,
                child: const LogupForm(),
              ),
            ),
            AnimatedPositioned(
              duration: defaultDuration,
              top: _size.height * 0.15,
              left: 0,
              right: _isShowSignUp ? - _size.width * 0.06 : _size.width * 0.06,
              child: CircleAvatar(
                radius: 70,
                child: AnimatedSwitcher(
                  duration: defaultDuration,
                  child: Image.asset("assets/logo.png"),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: defaultDuration,
              bottom: _isShowSignUp ? _size.height / 2 - 110: _size.height * 0.3,
              left: _isShowSignUp ? 0 : _size.width * 0.44 - 110,
              child: AnimatedDefaultTextStyle(
                duration: defaultDuration,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _isShowSignUp ? 14 : 20,
                fontWeight: FontWeight.bold,
                color: _isShowSignUp ? Colors.white : Colors.white10,
            ),
                child: Transform.rotate(
                  angle: -_animationTextRotate.value * pi / 180,
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: (){
                      if (_isShowSignUp){
                        updateView();
                      } else{
                        
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                      width: 220,
                      child: Text("Авторизация".toUpperCase()),
                    ),
                  ),
                ),
              ),
              ),
            AnimatedPositioned(
              duration: defaultDuration,
              bottom: !_isShowSignUp ? _size.height / 2 - 110 : _size.height * 0.3,
              right: _isShowSignUp ? _size.width * 0.44 - 110 : 0,
              child: AnimatedDefaultTextStyle(
                duration: defaultDuration,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: !_isShowSignUp ? 14 : 20,
                fontWeight: FontWeight.bold,
                color: _isShowSignUp ? Colors.white10 : Colors.white,
            ),
                child: Transform.rotate(
                  angle: (90 - _animationTextRotate.value) * pi / 180,
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: (){
                      if (_isShowSignUp){
                      } else{
                        updateView();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                      width: 220,
                      child: Text("Регистрация".toUpperCase(),),
                    ),
                  ),
                ),
              ),
              ),
          ],);
        }
      ),
    );
  }
}