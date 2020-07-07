import 'dart:async';

import 'package:e_commerce_demo/models/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper{

  Database _db;

  Future<Database> get db async
  {
    if (_db == null)
      _db = await initializeDb();
    return _db;
  }

  Future<Database> initializeDb() async
  {
    String dbPath = join(await getDatabasesPath(), "ecommerce.db");
    var eCommerceDb = openDatabase(dbPath, version: 3, onCreate: createDb);

    return eCommerceDb;
  }

  void createDb(Database db, int version) async
  {
    // id int primary key autoincrement
    await db.execute('''
    Create table products(
    id int primary key,
    productName text not null,
    productDescription text,
    productPrice real not null)
    ''');
  }

  Future<List<Product>> getAllProducts() async
  {
   Database db = await this.db;
   var products = await db.query("products");
   return List.generate(products.length,
//     (index){
//       return Product.fromObject(products[index]);
//     }
       (index) => Product.fromObject(products[index])
     );
  }

  Future<int> insertProduct(Product product) async
  {
    Database db = await this.db;
    var result = await db.insert(
        "products",
        product.toMap()
    );
    
    return result;
  }
  
  Future<int> deleteProduct(Product product) async
  {
    Database db = await this.db;
    var result = await db.delete(
      "products",
      where: "id=?",
      whereArgs: [product.id]
    );

    return result;
  }

  Future<int> updateProduct(Product product) async
  {
    Database db = await this.db;
    var result = await db.update(
      "products",
      product.toMap(),
      where: "id=?",
      whereArgs: [product.id]
    );

    return result;
  }
}