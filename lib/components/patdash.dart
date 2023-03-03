import 'dart:convert';
import 'package:app/components/patdoc.dart';
import 'package:app/services/authservice.dart';
import 'package:dio/dio.dart';
import 'package:app/components/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class patDashboard extends StatefulWidget {
  const patDashboard({super.key});

  @override
  State<patDashboard> createState() => _patDashboardState();
}

class _patDashboardState extends State<patDashboard> {
  List<dynamic> doctors = [];
  List<dynamic> id = [];
  var docid;
  Dio dio = Dio();
  @override
  void initState() {
    super.initState();
    getData(token);
  }

  void deleteItem(int index) {
    setState(() {
      doctors.removeAt(index);
    });
  }

  Future<void> getData(token) async {
    final response = await dio
        .post('http://localhost:3000/getAlldoc', data: {"patid": token});
    print(response);
    if (response.statusCode == 200) {
      print('here');
      setState(() {
        doctors = response.data;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

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
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                _navigateToNextScreenpatdoc(context);
              },
            ),
          ],
        ),
        body: Center(
          child: ListView.builder(
              itemCount: doctors.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Name: ${doctors[index]['name']}',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Speciality: ${doctors[index]['speciality']}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          docid = doctors[index]['_id'];
                          AuthService().setupMeeting(docid, token);
                          deleteItem(index);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // set the color when pressed
                        ),
                        child: const Text('Book'),
                      )
                    ],
                  ),
                );
              }),
        ));
  }

  void _navigateToNextScreenpatdoc(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const patdocDashboard(),
      ),
    );
  }
}
