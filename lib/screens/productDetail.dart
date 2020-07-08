import 'package:e_commerce_demo/data/dbHelper.dart';
import 'package:e_commerce_demo/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  Product product;

  ProductDetail(this.product);

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState(product);
  }
}

enum PopupOptions { DELETE, UPDATE }

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  var dbHelper = DbHelper();
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var priceController = TextEditingController();

  _ProductDetailState(this.product);

  @override
  void initState() {
    nameController.text = product.productName;
    descriptionController.text = product.productDescription;
    priceController.text = product.productPrice.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildProductDetail(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Details of " + product.productName),
      actions: <Widget>[
        buildPopupMenuButton(),
      ],
    );
  }

  PopupMenuButton<PopupOptions> buildPopupMenuButton() {
    return PopupMenuButton<PopupOptions>(
        onSelected: performSelectedOption,
        itemBuilder: (BuildContext context) => <PopupMenuEntry<PopupOptions>>[
              PopupMenuItem<PopupOptions>(
                value: PopupOptions.DELETE,
                child: Text("Delete"),
              ),
              PopupMenuItem<PopupOptions>(
                value: PopupOptions.UPDATE,
                child: Text("Update"),
              ),
            ]);
  }

  void performSelectedOption(PopupOptions option) async{
    switch (option) {
      case PopupOptions.DELETE:
        await dbHelper.deleteProduct(product);
        Navigator.pop(context, true);
        break;
      case PopupOptions.UPDATE:
        await dbHelper.updateProduct(Product.withId(
            product.id,
            nameController.text,
            descriptionController.text,
            double.tryParse(priceController.text)));
        Navigator.pop(context, true);
        break;
      default:
        UnimplementedError("There is no such option.");
    }
  }

  Padding buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: <Widget>[
          buildNameField(),
          buildDescriptionField(),
          buildPriceField(),
        ],
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
}
