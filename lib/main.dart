import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  Map data;

  getUser() async {
    Response response = await get('https://api.github.com/users/xkiRox');
    setState(() {
      data = json.decode(response.body);
      debugPrint(response.body);
    });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 50.0),
      child: _buildStack(data),
    );
  }
}

Widget _buildStack(data) => Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(data['avatar_url']),
              radius: 100,
            ),
            Container(
              margin: EdgeInsets.only(top: 140.0, left: 150.0),
              decoration: BoxDecoration(
                color: Colors.black45,
              ),
              child: Text(
                data['login'],
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 16.0),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.black45,
                ),
                child: Text(
                  'name',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 15),
                child: Center(
                  child: Text(
                    data['name'],
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10.0, top: 30.0),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.black45,
                ),
                child: Text(
                  'number public repos',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, top: 15),
                child: Center(
                  child: Text(
                    data['public_repos'].toString(),
                    style: TextStyle(
                        decoration: TextDecoration.none, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
