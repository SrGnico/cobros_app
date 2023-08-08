import 'package:sqflite/sqflite.dart';
import 'package:cobros_app/models/product.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static const int _version = 1;
  static const String _dbName = 'Products.db';

  static Future<Database> _getDB() async {

    return openDatabase(join(await getDatabasesPath(),_dbName),
      onCreate: (db, version) async =>
      await db.execute('CREATE TABLE Products(codigo STRING PRIMARY KEY, descripcion TEXT NOT NULL,categoria TEXT NOT NULL, precio TEXT NOT NULL);'), version: _version,
    );
  }

  static Future<int> addProduct(Product product) async{
    final db = await _getDB();

    return await db.insert(
      'Products', 
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> updateProduct(Product product) async {
    final db = await _getDB();

    return await db.update(
      'Products',
      product.toJson(),
      where: 'codigo = ?',
      whereArgs: [product.codigo],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> deleteProduct(Product product) async {
    final db = await _getDB();

    return await db.delete(
      'Products',
      where: 'codigo = ?',
      whereArgs: [product.codigo]
    );
  }

  static Future<List<Product>?> getAllProducts() async{

    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Products');

    if(maps.isEmpty){return null;}

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));

  }


  static Future getProductByCodigo(String codigo) async{

    final db = await _getDB();

    return await db.query(
      'Products',
      where: 'codigo = ?',
      whereArgs: [codigo]
    );

  }

}