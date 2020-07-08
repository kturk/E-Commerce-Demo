import 'package:e_commerce_demo/data/dbHelper.dart';
import 'package:e_commerce_demo/models/product.dart';
import 'package:flutter/material.dart';

import 'addProduct.dart';

class ProductList extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _ProductListState();
  }
}

class _ProductListState extends State<ProductList> {
  var dbHelper = DbHelper();
  List<Product> products;
  int productCount = 0;

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Products"),
      ),
      body: buildProductList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goAddProductScreen();
        },
        child: Icon(Icons.add),
        tooltip: "Add New Product",
      ),
    );
  }

  ListView buildProductList() {
    return ListView.builder(
        itemCount: productCount,
        itemBuilder: (BuildContext context, int index) {
          return buildEachProductLine(index);
        });
  }

  Card buildEachProductLine(int index) {
    return Card(
      color: Colors.blueAccent,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text("Product"),
        ),
        title: Text(this.products[index].productName),
        subtitle: Text(this
            .products[index]
            .productPrice
            .toString()), // description
        onTap: () {
          // TODO
        },
      ),
    );
  }

  void goAddProductScreen() async
  {
    bool result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddProduct()));
    if (result != null && result == true)
      getProducts();
  }

  void getProducts() async {
    var futureProducts = dbHelper.getAllProducts();
    futureProducts.then((value) {
      this.products = value;
      productCount = value.length;
    });
  }
}
