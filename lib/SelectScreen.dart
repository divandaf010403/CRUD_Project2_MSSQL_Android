import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project1_crud/UpdateScreen.dart';

class SelectScreen extends StatefulWidget {

  final String IpAddress;

  const SelectScreen({
    Key? key,
    required this.IpAddress,
  }) : super(key: key);

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {

  List users = [];

  final Random random = Random();
  final List<Color> cardColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
  ];

  Color _getRandomColor() {
    return cardColors[random.nextInt(cardColors.length)];
  }

  Future<void> fetchData(String thisIP) async {
    final response = await http.get(Uri.parse("http://$thisIP/magang/selectData.php"));

    if (response.statusCode == 200) {
      setState(() {
        users = List.from(json.decode(response.body));
        print(response.body);
      });
    } else {
      print("Failed to fetch users");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(widget.IpAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: _getRandomColor(),
                child: ListTile(
                  title: Text(users[index]['name'], style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                  subtitle: Text(users[index]['email'], style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(id: users[index]['id'] as int, ipAdd: widget.IpAddress,)));
              print(users[index]['id']);
            },
          );
        },
      ),
      // body: ListView.builder(
      //   itemCount: users.length,
      //   itemBuilder: (context, index) {
      //     return ListTile(
      //       title: Text(users[index]['name']),
      //       subtitle: Text(users[index]['email']),
      //       trailing: Text(users[index]['phone']),
      //     );
      //   },
      // ),
    );
  }
}
