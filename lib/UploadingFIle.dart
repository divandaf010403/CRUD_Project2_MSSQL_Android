import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:project1_crud/variable.dart';

class UploadingFile extends StatefulWidget {
  const UploadingFile({Key? key}) : super(key: key);

  @override
  State<UploadingFile> createState() => _UploadingFileState();
}

class _UploadingFileState extends State<UploadingFile> {

  String? fileName;
  String? filePath;
  List<int>? fileData;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      setState(() {
        fileName = file.name;
        filePath = file.path;
      });
    }
  }

  // Future<void> _uploadFile(String thisIp) async {
  //   if (_fileName != null) {
  //     if (_filePath != null) {
  //       var link = 'http://$thisIp/magang/uploadedFile.php';
  //
  //       //Projek Sebelah
  //       final responses = await http.post(
  //         Uri.parse(link),
  //         body: {
  //           'fileName' : _fileName,
  //           'filePath' : _filePath,
  //         },
  //       );
  //       print(link);
  //       if (responses.statusCode == 200) {
  //         print('File uploaded successfully');
  //       } else {
  //         print('File upload failed with status ${responses.statusCode}');
  //       }
  //
  //     } else {
  //       Fluttertoast.showToast(msg: 'File Path Should not be null', toastLength: Toast.LENGTH_SHORT);
  //     }
  //   } else {
  //     Fluttertoast.showToast(msg: 'File Name Should not be null', toastLength: Toast.LENGTH_SHORT);
  //   }
  // }

  // void uploadFileToServer(String fileName, List<int> fileData, String thisIp) async {
  //   if (fileName != null && fileData != null) {
  //     var url = 'http://$thisIp/magang/uploadedFile.php'; // Replace with your PHP server URL
  //
  //     var response = await http.post(
  //       Uri.parse(url),
  //       body: {
  //         'FileName': fileName,
  //         'FileData': fileData,
  //       },
  //     );
  //     print(url);
  //     print(fileName);
  //     print(base64Encode(fileData));
  //     print(fileData);
  //
  //     if (response.statusCode == 200) {
  //       print('File uploaded successfully');
  //     } else {
  //       print('Error uploading file');
  //     }
  //   }
  // }

  Future<void> uploadFile(String fileName, String filePath, String thisIp) async {
    File file = File(filePath);

    if (file.existsSync()) {
      List<int> bytes = await file.readAsBytes();
      String ext = filePath.split('.').last;

      String url = 'http://$thisIp/magang/uploadedFile.php';

      var request = http.MultipartRequest('POST', Uri.parse(url));
      print(url);
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        [7327432423],
      ));

      request.fields['fileName'] = 'hehe.txt';

      try {
        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          print('File uploaded successfully');
        } else {
          print('File upload failed');
        }
      } catch (e) {
        print('Error uploading file: $e');
      }
    } else {
      print('File not found: $filePath');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Pick a File'),
            ),
            SizedBox(height: 20),
            Text('Selected File Name : $fileName', style: TextStyle(fontSize: 18),),
            SizedBox(height: 20),
            Text('Selected File Path : $filePath', style: TextStyle(fontSize: 18),),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
                uploadFile(fileName!, filePath!, IpAddress!);
              },
              child: Text('Upload File To Database'),
            ),
          ],
        ),
      ),
    );
  }
}
