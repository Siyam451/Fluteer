import 'dart:convert';

import 'package:fluteer/asssignment/wigets/productList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'URLS/urls.dart';
import 'add_Newscreen.dart';
import 'models/product_model.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool ProductScreen = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _GetProductScreen();
  }


  final List<ProductModel> _ProductList =[];

  Future<void>_GetProductScreen()async{

    ProductScreen = true;
    setState(() {

    });
    Uri uri =Uri.parse(URL.getProductUrl);

    Response response =await get(uri);

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);
    if(response.statusCode == 200){
      final Decodejson = jsonDecode(response.body);

      _ProductList.clear();

      for(Map<String,dynamic>JsonProduct in Decodejson['data']){
        ProductModel productModel =ProductModel.fromJson(JsonProduct);
        _ProductList.add(productModel);
      }

      ProductScreen = false;
      setState(() {

      });


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
          IconButton(onPressed: (){
            _GetProductScreen();
          }, icon: Icon(Icons.refresh,size: 40,))
        ],
      ),

      body: Visibility(
        visible: ProductScreen==false,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.separated(
            itemCount: _ProductList.length,
            itemBuilder: (context,index){
              return Card(

                  child: Productlist(product: _ProductList[index], RefreshScreen: () { _GetProductScreen(); },)

              );

            },
            separatorBuilder: (context,index){
              return Divider(
                indent: 70,
                thickness: 5,
              );
            }

        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddScreen()));
      },child: Icon(Icons.add),),
    );
  }




}