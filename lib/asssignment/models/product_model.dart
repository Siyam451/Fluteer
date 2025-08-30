class ProductModel {
  late String id;
  late String name;
  late int code;
  late String image;
  late int quantity;
  late int unitPrice;
  late int totalPrice;


  ProductModel.fromJson(Map<String, dynamic>JsonProduct){
    id = JsonProduct['_id'];
    name = JsonProduct['ProductName'];
    code = JsonProduct['ProductCode'];
    image = JsonProduct['Img'];
    quantity = JsonProduct['Qty'];
    unitPrice = JsonProduct['UnitPrice'];
    totalPrice = JsonProduct['TotalPrice'];
  }


}