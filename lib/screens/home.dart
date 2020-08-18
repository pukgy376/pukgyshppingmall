import 'package:flutter/material.dart';
import 'package:pukgyshppingmall/screens/register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Method
  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      "Gy Shopping Mall",
      style: TextStyle(
        fontSize: 30.0,
        color: Colors.blue.shade700,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'FredokaOne',
      ),
    );
  }

  Widget signInButton() {
    return RaisedButton(
      color: Colors.blue.shade400,
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {},
    );
  }

  Widget signUpButton() {
    return OutlineButton(
      child: Text('Sign Up'),
      onPressed: () {
        print('you click singUp');
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Register());
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        SizedBox(
          width: 4.0,
        ),
        signUpButton()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          //กรณีของ safeArea จะสามารถเก็บของได้แค่อย่างเดียว คือคำสั่ง child
          child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.yellow.shade500],
            radius: 1.0,
            
          ),
        ),
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            showLogo(),
            showAppName(),
            SizedBox(
              height: 5.0,
            ),
            showButton(),
          ]),
        ),
      )),
    );
  }
}
