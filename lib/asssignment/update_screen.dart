import 'dart:convert';

import 'package:fluteer/asssignment/wigets/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


import 'URLS/urls.dart';
import 'models/product_model.dart';
class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key, required this.product});

  final ProductModel product;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  bool _RefreshUpdate = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _NameUPController = TextEditingController();
  TextEditingController _CodeUPController = TextEditingController();
  TextEditingController _QuantityUPController = TextEditingController();
  TextEditingController _UnitUPController = TextEditingController();
  TextEditingController _URLUPController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _NameUPController.text =widget.product.name;
    _CodeUPController.text =widget.product.code.toString();
    _QuantityUPController.text =widget.product.quantity.toString();
    _UnitUPController.text =widget.product.unitPrice.toString();
    _URLUPController.text =widget.product.image;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                      controller: _NameUPController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter Product Name',
                        labelText: 'Product Name',
                        hintStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (String ? value){
                        if(value!.trim().isEmpty){
                          return 'Enter valid value';
                        }
                        return null;
                      }

                  ),
                  SizedBox(height: 15,),
                  TextFormField(
                      controller: _CodeUPController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter Product Code',
                        labelText: 'Product Code',
                        hintStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (String ? value){
                        if(value!.trim().isEmpty){
                          return 'Enter valid value';
                        }
                        return null;
                      }

                  ),

                  SizedBox(height: 15,),
                  TextFormField(
                      controller: _QuantityUPController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter Quantity',
                        labelText: 'Quantity',
                        hintStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (String ? value){
                        if(value!.trim().isEmpty){
                          return 'Enter valid value';
                        }
                        return null;
                      }

                  ),

                  SizedBox(height: 15,),
                  TextFormField(
                      controller: _UnitUPController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter Unit Price',
                        labelText: 'Unit Price',
                        hintStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (String ? value){
                        if(value!.trim().isEmpty){
                          return 'Enter valid value';
                        }
                        return null;
                      }

                  ),

                  SizedBox(height: 15,),
                  TextFormField(
                      controller: _URLUPController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter URL',
                        labelText: 'URL',
                        hintStyle: TextStyle(color: Colors.red),
                      ),
                      validator: (String ? value){
                        if(value!.trim().isEmpty){
                          return 'Enter valid value';
                        }
                        return null;
                      }

                  ),

                  SizedBox(height: 25,),


                  Visibility(
                    visible: _RefreshUpdate== false,
                    child: FilledButton(
                        style:FilledButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.blue,

                        ),
                        onPressed: (){
                          _UpdateProduct();

                        }, child: Text('Update')),
                  )
                ],
              )
          ),
        )
    );

  }
  //something
  Future<void>_UpdateProduct()async{
    if(_formkey.currentState!.validate() == false) {
      return;
      //some
    }
    _RefreshUpdate = true;
    setState(() {

    });

    Uri uri = Uri.parse(URL.postUpdate(widget.product.id));
//prepare data

    Map<String,dynamic> Updatebody = {
      "ProductName": _NameUPController.text,
      "ProductCode": int.parse(_CodeUPController.text),
      "Img": _URLUPController.text,
      "Qty":int.parse (_QuantityUPController.text),
      "UnitPrice": int.parse(_UnitUPController.text),
      "TotalPrice": int.parse(_UnitUPController.text) * int.parse(_QuantityUPController.text),
    };

    //request

    Response response=await post(uri,headers:
    {
      'Content-Type' :'application/json',
    },
      body: jsonEncode(Updatebody),
    );

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if(response.statusCode == 200){
      final DecodeUpdate = jsonDecode(response.body);
      if(DecodeUpdate['status'] == 'success'){
        Showsnackbar(context, 'Product updated sucessfully');
      }else{

        final String errormassage = DecodeUpdate['data'];
        Showsnackbar(context, errormassage);
      }
    }
//
    _RefreshUpdate == false;
    setState(() {

    });

  }
}