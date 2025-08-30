import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../URLS/urls.dart';
import '../models/product_model.dart';
import '../update_screen.dart';
class Productlist extends StatefulWidget {
  const Productlist({super.key, required this.product, required this.RefreshScreen});
  final ProductModel product;
  final VoidCallback RefreshScreen;

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {



  bool _deleteRefresh = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.product.image,
          width: 40,
          errorBuilder: (_,__,___) {
            return Icon(Icons.error);//no image then it will show
          }
      ),
      title: Text('Product name: ${widget.product.name}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Code:${widget.product.code}'),
          Row(
            spacing: 16,
            children: [
              Text('Quantity:${widget.product.quantity}'),
              Text('Unit Price:${widget.product.unitPrice}')
            ],
          ),


        ],
      ),
      trailing:  Visibility(
        visible: _deleteRefresh == false,
        replacement: CircularProgressIndicator(),
        child: PopupMenuButton<PopUpoptions>(itemBuilder: (context){
          return[
            PopupMenuItem(value: PopUpoptions.delete,child: Text('Delete')),
            PopupMenuItem(value: PopUpoptions.update,child: Text('update')),

          ];

        },
            onSelected: (PopUpoptions Onselecteditems){
              if(PopUpoptions.delete == Onselecteditems){
                _deleteProduct();
              }else if(PopUpoptions.update == Onselecteditems){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateScreen(product: widget.product,)));
              }
            }
        ),
      ),

    );
  }
  Future<void> _deleteProduct()async {
    _deleteRefresh = true;
    setState(() {

    });
    Uri uri = Uri.parse(URL.getDeleteUrl(widget.product.id));

    Response response = await get(uri);

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if (response.statusCode == 200) {
      widget.RefreshScreen(); //delete the product

    }
    _deleteRefresh = false;
    setState(() {

    });
  }
//
}
enum PopUpoptions{
  update,
  delete,
}