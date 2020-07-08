import 'package:e_commerce_demo/data/dbHelper.dart';
import 'package:e_commerce_demo/models/product.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget{
  @override
  State<StatefulWidget> createState()
  {
    return _AddProductState();
  }

}

class _AddProductState extends State<AddProduct>{

  var dbHelper = DbHelper();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildDescriptionField(),
            buildPriceField(),
            buildSaveButton()
          ],
        ),
      ),
    );
  }

  TextField buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Name of the Product"),
      controller: nameController,
    );
  }

  TextField buildDescriptionField() {
    return TextField(
      decoration: InputDecoration(labelText: "Description of the Product"),
      controller: descriptionController,
    );
  }

  TextField buildPriceField() {
    return TextField(
      decoration: InputDecoration(labelText: "Price of the Product"),
      controller: priceController,
    );
  }

  FlatButton buildSaveButton() {
    return FlatButton(
      child: Text("Add"),
      onPressed: (){
        addProduct();
      },
    );
  }

  void addProduct() async
  {
    var result = await dbHelper.insertProduct(
        Product(
            nameController.text,
            descriptionController.text,
            double.tryParse(priceController.text)));
    Navigator.pop(context, true);
  }

}
