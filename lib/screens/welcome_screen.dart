import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/round_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  /// Animation variables
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: Duration(seconds: 2), vsync: this, upperBound: 1);

    controller.forward();

    ///controller.reverse(from: 1.0);

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

//    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
//
//    animation.addStatusListener(
//      (status) {
////      status == AnimationStatus.completed
////          ? controller.reverse(from: 1.0)
////          : controller.forward();
//        if (status == AnimationStatus.completed) {
//          controller.reverse(from: 1.0);
//        } else if (status == AnimationStatus.dismissed) {
//          controller.forward();
//        }
//      },
//    );

    controller.addListener(
      () {
        setState(() {});
      },
    );
  }

  /// End of initState()

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /// Flash Chat title
            Row(
              children: <Widget>[
                Hero(
                  /// Beginning of the Hero widget
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),

            /// Log In Button
            RoundedButton(
              roundButtonColor: Colors.lightBlueAccent,
              roundButtonLabel: 'Log In',
              onPressRoute: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),

            /// Register Button
            RoundedButton(
              roundButtonColor: Colors.blueAccent,
              roundButtonLabel: 'Register',
              onPressRoute: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}