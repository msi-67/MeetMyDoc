import 'package:app/components/docdash.dart';
import 'package:app/components/signupdoc.dart';
import 'package:app/services/authservicedoc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreenDoc extends StatefulWidget {
  const LoginScreenDoc({super.key});

  @override
  State<LoginScreenDoc> createState() => _LoginScreenState();
}

var docid;

class _LoginScreenState extends State<LoginScreenDoc> {
  var name, password, username, mobile, token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
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
                  'Welcome Back Doc!',
                  style: TextStyle(fontSize: 20),
                )),
            TextField(
              scrollPadding: const EdgeInsets.all(5),
              decoration: const InputDecoration(labelText: 'username'),
              onChanged: (val) {
                username = val;
              },
            ),
            TextField(
              scrollPadding: const EdgeInsets.all(5),
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
                  AuthService().login(username, password).then((val) {
                    if (val.data['success']) {
                      token = val.data['token'];
                      docid = val.data['_id'];
                      print(docid);
                      Fluttertoast.showToast(
                          msg: 'Authenticated',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      _navigateToNextScreenDocsus(context);
                    }
                  });
                },
                child: const Text('Login'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  _navigateToNextScreenDoctor(context);
                },
                child: const Text('Signup'),
              ),
            )
          ],
        ));
  }

  void _navigateToNextScreenDoctor(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const signUpScreenDoc(),
      ),
    );
  }

  void _navigateToNextScreenDocsus(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const docDashboard(),
      ),
    );
  }
}
