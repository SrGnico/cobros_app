import 'package:sqflite/sqflite.dart';
import 'package:cobros_app/models/product.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static const int _version = 1;
  static const String _dbName = 'Productos.db';

  static Future<Database> _getDB() async {

    return openDatabase(join(await getDatabasesPath(),_dbName),
      onCreate: (db, version) async =>
      await db.execute('CREATE TABLE Productos(codigo TEXT PRIMARY KEY, descripcion TEXT NOT NULL,categoria TEXT NOT NULL, precio TEXT NOT NULL);'), version: _version,
    );
  }

  static Future<int> addProduct(Product product) async{
    final db = await _getDB();

    return await db.insert(
      'Productos', 
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> updateProduct(Product product) async {
    final db = await _getDB();

    return await db.update(
      'Productos',
      product.toJson(),
      where: 'codigo = ?',
      whereArgs: [product.codigo],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> deleteProduct(Product product) async {
    final db = await _getDB();

    return await db.delete(
      'Productos',
      where: 'codigo = ?',
      whereArgs: [product.codigo]
    );
  }

  static Future<List<Product>> getProductByCodigo(String codigo) async{

    final db = await _getDB();

   final List<Map<String, dynamic>> maps = await db.query(
    'Productos',
    where: 'codigo = ?',
    whereArgs: [codigo]
    );
  
    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));

  }


  static Future<List<Product>?> getAllProducts() async{

    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Productos',orderBy: 'codigo DESC');

    if(maps.isEmpty){return null;}

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));

  }

   static Future<List<Product>?> getProductByCategoria(String categoria) async{

    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'Productos',
      where: 'categoria = ?',
      whereArgs: [categoria]
    );

    if(maps.isEmpty){return null;}

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));

  }

/*
  static Future deleteDb()async{
    final db = await _getDB();

    return db.execute('DROP TABLE Products');

  }
*/

  static Future updatePrices(List<String> codigos, String precioNuevo)async{
    final db = await _getDB();

    final batch = db.batch();

    for(int i = 0; i < codigos.length; i++){
      batch.rawUpdate('''
        UPDATE Productos
        SET precio = ?
        WHERE codigo = ?
      ''',
      [precioNuevo,codigos[i]]
      );
    }

    await batch.commit(noResult: true,continueOnError: true );

  }

   static Future<List<Product>?> getProductBySearch(String search) async{

    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'Productos',
      where: 'descripcion LIKE ? OR codigo LIKE ?',
      whereArgs: ['%$search%','%$search%']
    );

    if(maps.isEmpty){return null;}

    return List.generate(maps.length, (index) => Product.fromJson(maps[index]));

  }

}