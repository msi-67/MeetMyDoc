import 'dart:convert';
import 'package:app/services/authservicedoc.dart';
import 'package:dio/dio.dart';
import 'package:app/components/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:app/components/logindoc.dart';

class patdocDashboard extends StatefulWidget {
  const patdocDashboard({super.key});

  @override
  State<patdocDashboard> createState() => _patdocDashboardState();
}

class _patdocDashboardState extends State<patdocDashboard> {
  List<dynamic> docs = [];
  Dio dio = Dio();
  @override
  void initState() {
    super.initState();
    getData(token);
  }

  void deleteItem(int index) {
    setState(() {
      docs.removeAt(index);
    });
  }

  Future<void> getData(token) async {
    final response = await dio
        .post('http://localhost:3000/getMydoctors', data: {"patid": token});
    print(response);
    if (response.statusCode == 200) {
      print('here');
      setState(() {
        docs = response.data;
        print(docs);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: docs.length,
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
                        'Name: ${docs[index]['name']}',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // set the color when pressed
                        ),
                        child: const Text('Time'),
                      )
                    ],
                  ),
                );
              }),
        ));
  }
}
