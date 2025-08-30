import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

// fix your import path here properly
import 'package:fluteer/asssignment/wigets/snackbars.dart';


class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  bool addScreenIndicator = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _quantityController.dispose();
    _unitController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Enter Product Name',
                  labelText: 'Product Name',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Enter valid value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Enter Product Code',
                  labelText: 'Product Code',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Enter valid value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _quantityController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Enter Quantity',
                  labelText: 'Quantity',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Enter valid value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _unitController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Enter Unit Price',
                  labelText: 'Unit Price',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Enter valid value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _urlController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: 'Enter URL',
                  labelText: 'URL',
                  hintStyle: TextStyle(color: Colors.red),
                ),
                validator: (String? value) {
                  if (value!.trim().isEmpty) {
                    return 'Enter valid value';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Visibility(
                visible: addScreenIndicator == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: FilledButton(
                  onPressed: () {
                    _addProductScreen();
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addProductScreen() async {
    if (_formKey.currentState!.validate() == false) {
      return; // form not valid
    }

    addScreenIndicator = true;
    setState(() {});

    Uri uri = Uri.parse('http://35.73.30.144:2008/api/v1/CreateProduct');

    Map<String, dynamic> requestBody = {
      "ProductName": _nameController.text,
      "ProductCode": int.parse(_codeController.text),
      "Img": _urlController.text,
      "Qty": int.parse(_quantityController.text),
      "UnitPrice": int.parse(_unitController.text),
      "TotalPrice": int.parse(_quantityController.text) *
          int.parse(_unitController.text),
    };

    Response response = await post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final decodeJson = jsonDecode(response.body);
      if (decodeJson['status'] == 'success') {
        textClear();
        Navigator.pop(context);
        Showsnackbar(context, 'Created successfully');
      } else {
        String errorMessage = decodeJson['data'].toString();
        Showsnackbar(context, errorMessage);
      }
    }

    addScreenIndicator = false;
    setState(() {});
  }

  void textClear() {
    _nameController.clear();
    _unitController.clear();
    _quantityController.clear();
    _urlController.clear();
    _codeController.clear();
  }
}
