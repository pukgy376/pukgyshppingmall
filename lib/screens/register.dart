import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
// Explicit
  final formKey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;
// Method

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        print('You Click Upload');
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          print(
              'name = $nameString, email=$emailString, password=$passwordString');
          registerThread();
        }
      },
    );
  }

//ขั้นตอนการเชื่อง Firebase
  //Thread คือการสั่งให้ทำจนกว่าจะได้ ถ้าได้จะผ่านเข้ามาได้
  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    //await คือ ทำให้ต้องสำเร็จเท่านั้น
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((response) {
      print('Register Success For Email = $emailString');
    }).catchError((response) {
      String title = response.code;
      String message = response.message;
      print('title = $title, message = $message');
      myAlert(title, message);
    });
  }

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.red,size: 48.0,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.red),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Widget nameText() {
    return TextFormField(
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        //วิธีใส่ Icon ในช่องกรอก
        icon: Icon(
          Icons.face,
          color: Colors.blue.shade400,
          size: 48.0,
        ),
        labelText: 'Display Name :',
        labelStyle: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'Type Your Nick Name for Display',
        helperStyle: TextStyle(
          color: Colors.blue,
          fontStyle: FontStyle.italic,
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Your Name in The Blank';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.green.shade400),
      decoration: InputDecoration(
        //วิธีใส่ Icon ในช่องกรอก
        icon: Icon(
          Icons.email,
          color: Colors.green.shade400,
          size: 48.0,
        ),
        labelText: 'Display Email :',
        labelStyle: TextStyle(
          color: Colors.green.shade400,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'Type Your Email',
        helperStyle: TextStyle(
          color: Colors.green,
          fontStyle: FontStyle.italic,
        ),
      ),
      validator: (String value) {
        //กรณีเป็น EMAIL แล้วต้องการตรวจสอบว่าเป็นอีเมลไหม ใช้คำสั่งนี้
        // ! = null
        if (!((value.contains('@')) && (value.contains('.')))) {
          return 'Please Type Email In Exp. you@gmail.com';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget passwordText() {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.orange.shade400),
      decoration: InputDecoration(
        //วิธีใส่ Icon ในช่องกรอก
        icon: Icon(
          Icons.lock,
          color: Colors.orange.shade400,
          size: 48.0,
        ),
        labelText: 'Display Password :',
        labelStyle: TextStyle(
          color: Colors.orange.shade400,
          fontWeight: FontWeight.bold,
        ),
        helperText: 'Type Your Password more 6 Charactor',
        helperStyle: TextStyle(
          color: Colors.orange.shade400,
          fontStyle: FontStyle.italic,
        ),
      ),
      //เป็นการนับจำนวนรหัสผ่านว่ามีตัวเลขน้อยหว่า6ตัวหรือไม่
      validator: (String value) {
        if (value.length < 6) {
          return 'Please More 6 Charactor';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade500,
        title: Text('Register'),
        actions: <Widget>[registerButton()],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(30.0),
          children: <Widget>[
            nameText(),
            emailText(),
            passwordText(),
          ],
        ),
      ), // listview จะคล้ายๆ colum แต่ listview จะ scor ได้
    );
  }
}
