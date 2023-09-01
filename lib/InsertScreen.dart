import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {

  final String IpAddress;

  const MainScreen({
    Key? key,
    required this.IpAddress
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // final TextEditingController ipAdd = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<dynamic> data = [];

  Future<void> insertData(ipAddress) async {
    final url = Uri.parse('http://${ipAddress}/magang/insertData.php');
    final response = await http.post(
      url,
      body: {
        'name': name.text,
        'email': email.text,
        'phone' : phone.text,
      },
    );

    if (response.statusCode == 200) {
      print('Data inserted successfully');
      Fluttertoast.showToast(msg: 'Insert Data Successfull', toastLength: Toast.LENGTH_SHORT);
      Navigator.pop(context);
    } else {
      print('Failed to insert data');
      Fluttertoast.showToast(msg: 'Insert Data Failed', toastLength: Toast.LENGTH_SHORT);
    }
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
      appBar: AppBar(
        title: Text('Insert Data'),
      ),
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
                            // Navigator.pushNamed(context, '/navbar');
                            try {
                              if(_formKey.currentState!.validate()) {
                                insertData(widget.IpAddress);
                              }
                            } catch (e) {

                            }
                          },
                          child: const Text('Input'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40,),
                ],
              )
          )
      ),
    );
  }
}
