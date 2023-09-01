import 'package:flutter/material.dart';
import 'package:project1_crud/variable.dart';

class ScreenController extends StatefulWidget {
  const ScreenController({Key? key}) : super(key: key);

  @override
  State<ScreenController> createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {

  final TextEditingController ipAdd = TextEditingController();

  final GlobalKey<FormState> _ipAddConf = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ipAdd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _ipAddConf,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: ipAdd,
                decoration: const InputDecoration(
                  labelText: 'Server IP Address',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input Your Server IP Address';
                  }
                  return null;
                },
              ),
              SizedBox(height: 60,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  try {
                    if(_ipAddConf.currentState!.validate()) {
                      IpAddress = ipAdd.text;
                      Navigator.pushNamed(context, '/insert');
                    }
                  } catch(e) {

                  }
                },
                child: const Text(
                  'Insert Data',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  try {
                    if(_ipAddConf.currentState!.validate()) {
                      IpAddress = ipAdd.text;
                      Navigator.pushNamed(context, '/select');
                    }
                  } catch (e) {

                  }
                },
                child: const Text(
                  'User Data List',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
                onPressed: () {
                  try {
                    if(_ipAddConf.currentState!.validate()) {
                      IpAddress = ipAdd.text;
                      Navigator.pushNamed(context, '/file');
                    }
                  } catch (e) {

                  }
                },
                child: const Text(
                  'Upload Data File To Database',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
