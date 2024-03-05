import 'dart:convert';
import 'dart:typed_data';

import 'package:dmrtd_plugin/dmrtd_plugin.dart';
import 'package:dmrtd_plugin/models/document..dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _dmrtdPlugin = DmrtdPlugin();
  Document? _document;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            ElevatedButton(
              onPressed: initPlatformState,
              child: const Text("Start"),
            ),
            if (_document != null) ...[
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('DocType: ${_document!.docType.name}'),
                    ),
                    ListTile(
                      title: Text('Name: ${_document!.documentDetails.name ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Surname: ${_document!.documentDetails.surname ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Personal Number: ${_document!.documentDetails.personalNumber ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Gender: ${_document!.documentDetails.gender ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Birth Date: ${_document!.documentDetails.birthDate ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Issue Date: ${_document!.documentDetails.issueDate ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Expiry Date: ${_document!.documentDetails.expiryDate ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Serial Number: ${_document!.documentDetails.serialNumber ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Nationality: ${_document!.documentDetails.nationality ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Issuer Authority: ${_document!.documentDetails.issuerAuthority ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Face Image: ${_document!.documentDetails.faceImageBase64 ?? "Unknown"}'),
                    ),

                    ListTile(
                      title: Text('Portrait Image Base64: ${_document!.documentDetails.portraitImageBase64 ?? "Unknown"}'),
                      trailing: IconButton(
                      icon: Icon(Icons.content_copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _document!.documentDetails.portraitImageBase64 ?? ""));
                         ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Copied to clipboard")),
                          );
                        },
                       ),
                     ),
                    ListTile(
                      title: Text('Signature Base64: ${_document!.documentDetails.signatureBase64 ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('Personal number: ${_document!.personDetails.personalNumber ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('permanentAddress: ${_document!.personDetails.permanentAddress ?? "Unknown"}'),
                    ),
                    ListTile(
                      title: Text('placeOfBirth : ${_document!.personDetails.placeOfBirth ?? "Unknown"}'),
                    ),
                    // Ajouter les autres propriétés ici
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    Document? result;
    try {
      String passportNumber = "408098025";
      String expirationDate = "331226";
      String birthDate = "010827";
      result = await _dmrtdPlugin.read(passportNumber, expirationDate, birthDate, _onStatusChange);
      debugPrint("result $result");
    } catch (e) {
      debugPrint("error $e");
    }

    if (!mounted) return;

    setState(() {
      _document = result;
    });
  }



  void _onStatusChange(String status) {
    debugPrint("status change $status");
    setState(() {
      _platformVersion = status;
    });
  }
}
