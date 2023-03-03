import 'package:app/services/authservicedoc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class signUpScreenDoc extends StatefulWidget {
  const signUpScreenDoc({super.key});

  @override
  State<signUpScreenDoc> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<signUpScreenDoc> {
  var name, password, username, mobile, token, speciality;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SignUp'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'MeetyourDoc',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Hey Doc!',
                  style: TextStyle(fontSize: 20),
                )),
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (val) {
                name = val;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'username'),
              onChanged: (val) {
                username = val;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'mobile'),
              onChanged: (val) {
                mobile = val;
              },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'speciality'),
              onChanged: (val) {
                speciality = val;
              },
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'password'),
              onChanged: (val) {
                password = val;
              },
            ),
            const SizedBox(height: 10.0),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  AuthService()
                      .addUser(name, username, speciality, mobile, password)
                      .then((val) {
                    Fluttertoast.showToast(
                        msg: val.data['msg'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                },
                child: const Text('Signup'),
              ),
            )
          ],
        ));
  }
}
