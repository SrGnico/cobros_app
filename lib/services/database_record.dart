import 'package:cobros_app/models/cart.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseRecord{

  static const int _version = 1;
  static const String _dbName = 'Registros.db';

  static Future<Database> _getDB() async{

    return openDatabase(join(await getDatabasesPath(),_dbName),
      onCreate: (db, version) async => 
      await db.execute('CREATE TABLE Registros(fecha TEXT PRIMARY KEY,cantidadVentas TEXT NOT NULL,total TEXT NOT NULL,totalTransferencia TEXT NOT NULL,totalEfectivo TEXT NOT NULL,cantidadProductos TEXT NOT NULL,almacenTotal TEXT NOT NULL,lacteosTotal TEXT NOT NULL,congeladosTotal TEXT NOT NULL,bebidasTotal TEXT NOT NULL,limpiezaTotal TEXT NOT NULL,perfumeriaTotal TEXT NOT NULL,sueltosTotal TEXT NOT NULL);'), version: _version,
    );

  }

  static Future<int> addRecord(Cart cart) async{
    final db = await _getDB();

    return await db.insert(
      'Registros', 
      cart.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );

  }

  static Future<int> updateRecord(Cart cart) async{
    final db = await _getDB();

    return await db.update(
      'Registros', 
      cart.toJson(),
      where: 'fecha = ?',
      whereArgs: [cart.fecha],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> deleteRecord(Cart cart) async{
    final db = await _getDB();

    return await db.delete(
      'Registros',
      where: 'fecha = ?',
      whereArgs: [cart.fecha],
    );

  }

  static Future<List<Cart>?> getRecordByDate(String date)async{
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'Registros',
      where: 'fecha = ?',
      whereArgs: [date]
    );

    return List.generate(maps.length, (index) => Cart.fromJson(maps[index]));
  }  

  static Future<List<Cart>?> getAllRecords() async{
    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query('Registros', orderBy:'fecha DESC');

    if(maps.isEmpty){return null;}

    return List.generate(maps.length, (index) => Cart.fromJson(maps[index]));
  }

  static Future<List<Cart>?> getRecordBySearch(String date) async{

    final db = await _getDB();

    final List<Map<String, dynamic>> maps = await db.query(
      'Productos',
      where: 'fecha LIKE ?',
      whereArgs: ['%$date%']
    );

    if(maps.isEmpty){return null;}

    return List.generate(maps.length, (index) => Cart.fromJson(maps[index]));


  }

}