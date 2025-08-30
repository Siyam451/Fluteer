import 'package:flutter/material.dart';

void Showsnackbar(BuildContext context,title){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
}