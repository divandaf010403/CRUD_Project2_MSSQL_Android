import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:project1_crud/variable.dart';

class UpdateScreen extends StatefulWidget {

  final int id;
  final String ipAdd;

  const UpdateScreen({
    Key? key,
    required this.id,
    required this.ipAdd
  }) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future _getData(String ServerIP) async {
    try {
      var link = "http://$ServerIP/magang/getData.php?id=${widget.id}";
      final response = await http.get(
        Uri.parse(link),
      );
      print(link);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(response.body);


        setState(() {
          print('my id ${widget.id}');
          name = TextEditingController(text: data[0]['name']);
          email = TextEditingController(text: data[0]['email']);
          phone = TextEditingController(text: data[0]['phone']);
          // print(data[0]['name']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onUpdate(context, String ServerIP) async {
    var link = 'http://$ServerIP/magang/updateData.php';
    final url = Uri.parse(link);
    print(link);
    final response = await http.post(
      url,
      body: {
        'id' : widget.id.toString(),
        'name': name.text,
        'email': email.text,
        'phone' : phone.text,
      },
    );

    if (response.statusCode == 200) {
      print('Data Edited successfully');
      Navigator.pushNamed(context, '/select').then((value) => setState((){}));
      Fluttertoast.showToast(msg: 'Data Edited Successfull', toastLength: Toast.LENGTH_SHORT);
    } else {
      print('Failed to Edit data');
      Fluttertoast.showToast(msg: 'Data Edited Failed', toastLength: Toast.LENGTH_SHORT);
    }
  }

  Future<void> deleteUser(context, String ServerIP) async {
    var link = 'http://$ServerIP/magang/deleteData.php';
    final url = Uri.parse(link);
    print(link);
    final response = await http.post(
      url,
      body: {
        'id' : widget.id.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('Data Deleted successfully');
      Navigator.pushNamed(context, '/select').then((value) => setState((){}));
      Fluttertoast.showToast(msg: 'Data Deleted Successfull', toastLength: Toast.LENGTH_SHORT);
    } else {
      print('Failed to Delete data');
      Fluttertoast.showToast(msg: 'Data Delete Failed', toastLength: Toast.LENGTH_SHORT);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData(IpAddress!);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name.dispose();
    email.dispose();
    phone.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                        const Text(
                          'Add Your Data',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: name,
                          decoration: const InputDecoration(
                            labelText: 'Your Name',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Your Name is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Phone Number is required';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async{
                            _onUpdate(context, IpAddress!);
                          },
                          child: const Text('Edit User Data'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                ],
              )
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          deleteUser(context, IpAddress!);
        },
        label: Text('Delete User'),
        icon: Icon(Icons.delete),
      ),
    );
  }
}
