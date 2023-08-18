import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:cobros_app/models/cart.dart';
import 'package:cobros_app/models/category.dart';
import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/services/database_product.dart';
import 'package:cobros_app/services/database_record.dart';
import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:cobros_app/widgets/button/conditional_button.dart';
import 'package:cobros_app/widgets/cart/product_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class CashScreen extends StatefulWidget {

  const CashScreen({super.key});

  @override
  State<CashScreen> createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> {

  int total = 0;
  List<Product> cart = [];
  List<String> editingList = [];
  int totalTransferencia = 0;
  int totalEfectivo = 0;
  int cantidadProductos = 0;
  int almacenTotal = 0;
  int lacteosTotal = 0;
  int congeladosTotal = 0;
  int bebidasTotal = 0;
  int limpiezaTotal = 0;
  int perfumeriaTotal = 0;
  int sueltosTotal = 0;

  bool shouldPop = false;

  var precioManual = TextEditingController();

  resetEverything(){
    total = 0;
    cart = [];
    editingList = [];
    totalTransferencia = 0;
    totalEfectivo = 0;
    cantidadProductos = 0;
    almacenTotal = 0;
    lacteosTotal = 0;
    congeladosTotal = 0;
    bebidasTotal = 0;
    limpiezaTotal = 0;
    perfumeriaTotal = 0;
    sueltosTotal = 0;

    setState(() {
      context.pop();
    });
  }

  void addToCategoryTotal(String category, String precio){

    switch (category){
      case 'Almacen':
        almacenTotal += int.parse(precio);
      case 'Lacteos':
        lacteosTotal += int.parse(precio);
      case 'Congelados':
        congeladosTotal += int.parse(precio);
      case 'Bebidas':
        bebidasTotal += int.parse(precio);
      case 'Limpieza':
        limpiezaTotal += int.parse(precio);
      case 'Perfumeria':
        perfumeriaTotal += int.parse(precio);
      case 'Suelto':
        sueltosTotal += int.parse(precio);
    }

  }

    void minusToCategoryTotal(String category, String precio){

    switch (category){
      case 'Almacen':
        almacenTotal -= int.parse(precio);
      case 'Lacteos':
        lacteosTotal -= int.parse(precio);
      case 'Congelados':
        congeladosTotal -= int.parse(precio);
      case 'Bebidas':
        bebidasTotal -= int.parse(precio);
      case 'Limpieza':
        limpiezaTotal -= int.parse(precio);
      case 'Perfumeria':
        perfumeriaTotal -= int.parse(precio);
      case 'Suelto':
        sueltosTotal -= int.parse(precio);
    }

  }

  void addItemToCart(String codigo) async {
    List<Product> lista = await DatabaseHelper.getProductByCodigo(codigo);

    if(lista.isEmpty){
      return;
    }

    Product item = lista[0];

    var exists = cart.where((element) => element.codigo == item.codigo);
    if(exists.isNotEmpty){
      addOneMoreToCart(item.codigo, item.precio);
      addToCategoryTotal(item.categoria, item.precio);
      setState(() {
        calculateTotal();
      });
    }
    else{
      addToCategoryTotal(item.categoria, item.precio);
      setState(() {
        cantidadProductos++;  
        cart.add(item);
        calculateTotal();
      });
    }

  }

  void calculateTotal(){
    total = 0;
    for(int i = 0; i < cart.length; i++){
      total += int.parse(cart[i].precio);
    }
  }

  void addOneMoreToCart(String codigo, String precioOriginal){
    if(int.parse(codigo) < 100){return;}
    final index = cart.indexWhere((item) => item.codigo == codigo );
    int nuevoPrecio = int.parse(cart[index].precio) + int.parse(precioOriginal);
    cantidadProductos++;
    cart[index] = Product(
      codigo: cart[index].codigo, 
      descripcion: cart[index].descripcion.contains('×')
      ? '${(int.parse(cart[index].descripcion.characters.first) + 1 ).toString()}${cart[index].descripcion.substring(1)}  '
      : '2 × ${cart[index].descripcion}', 
      categoria: cart[index].categoria, 
      precio: nuevoPrecio.toString(),
    );
  }

   void removeOneMoreFromCart(String codigo) async{
    if(int.parse(codigo) < 100){ 
      return;
    }

    List<Product> lista = await DatabaseHelper.getProductByCodigo(codigo);
    Product item = lista[0];

    final index = cart.indexWhere((item) => item.codigo == codigo );

    int nuevoPrecio = int.parse(cart[index].precio) - int.parse(item.precio);
    minusToCategoryTotal(item.categoria, item.precio);
    cantidadProductos--;
    if(nuevoPrecio == 0){
      cart.removeWhere((item) => item.codigo == codigo);
      setState(() {
        editingList = [];
        calculateTotal();
        if(context.canPop()){
          context.pop();
        }
      });
      return;
    }
    cart[index] = Product(
      codigo: cart[index].codigo, 
      descripcion: cart[index].descripcion.contains('×')
      ? '${(int.parse(cart[index].descripcion.characters.first) - 1 ).toString()}${cart[index].descripcion.substring(1)}  '
      : '2 × ${cart[index].descripcion}', 
      categoria: cart[index].categoria, 
      precio: nuevoPrecio.toString(),
    );
    setState(() {
      calculateTotal();
    });
  }

  
  void addProductToEditingList(String codigo){
    editingList.add(codigo);
    if(editingList.length == 1){
      setState(() {});
    }
  }

  void deleteProductFromEditingList(String codigo){
    if(editingList.length == 1){
      setState(() {});
    }
    editingList.remove(codigo);
  }

  addCartToRecord()async {
    int day = DateTime.now().day;
    int month = DateTime.now().month;
    int year = DateTime.now().year;
    String date = '$day/$month/$year';

    List<Cart>? actualCart = await DatabaseRecord.getRecordByDate(date);

    if(actualCart!.isNotEmpty){
      Cart item = actualCart[0];

      Cart newCart = Cart(
        fecha: date, 
        cantidadVentas: (int.parse(item.cantidadVentas) + 1 ).toString(), 
        total: (int.parse(item.total) + total).toString(), 
        totalTransferencia: (int.parse(item.totalTransferencia) + totalTransferencia).toString(), 
        totalEfectivo: (int.parse(item.totalEfectivo) + totalEfectivo).toString(), 
        cantidadProductos: (int.parse(item.cantidadProductos) + cantidadProductos).toString(), 
        almacenTotal: (int.parse(item.almacenTotal) + almacenTotal).toString(), 
        lacteosTotal: (int.parse(item.lacteosTotal) + lacteosTotal).toString(), 
        congeladosTotal: (int.parse(item.congeladosTotal) + congeladosTotal).toString(), 
        bebidasTotal: (int.parse(item.bebidasTotal) + bebidasTotal).toString(), 
        limpiezaTotal: (int.parse(item.limpiezaTotal) + limpiezaTotal).toString(), 
        perfumeriaTotal: (int.parse(item.perfumeriaTotal) + perfumeriaTotal).toString(), 
        sueltosTotal: (int.parse(item.sueltosTotal) + sueltosTotal).toString(), 
      );

      DatabaseRecord.updateRecord(newCart);
      
    }

    else{
      setState(() {
        
      });

       Cart newCart = Cart(
        fecha: date, 
        cantidadVentas: '1', 
        total: total.toString(), 
        totalTransferencia: totalTransferencia.toString(), 
        totalEfectivo: totalEfectivo.toString(), 
        cantidadProductos: cantidadProductos.toString(), 
        almacenTotal: almacenTotal.toString(), 
        lacteosTotal: lacteosTotal.toString(), 
        congeladosTotal: congeladosTotal.toString(), 
        bebidasTotal: bebidasTotal.toString(), 
        limpiezaTotal: limpiezaTotal.toString(), 
        perfumeriaTotal: perfumeriaTotal.toString(), 
        sueltosTotal: sueltosTotal.toString()
      );
      DatabaseRecord.addRecord(newCart);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 150,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cobros',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '\$ $total',
              maxLines: 1,
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
    
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,50,10,0),
            child: IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: editingList.isEmpty
              ?() async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String){
                    if(res == '-1') return;
                    addItemToCart(res);
                  }
                });
              }
              :(){
                for(int i = 0; i<editingList.length; i++){
                  if(int.parse(editingList[i]) < 100 ){
                    var sueltos = cart.where((item)=>item.codigo == editingList[i]);
                    var suelto = sueltos.first;
                    minusToCategoryTotal(suelto.categoria, suelto.precio);
                    cantidadProductos--;
                  }
                  cart.removeWhere((item) => item.codigo == editingList[i]);
                }
                setState(() {
                  editingList = [];
                  calculateTotal();
                });
              }, 
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  editingList.isEmpty
                  ?  Icons.qr_code_scanner_rounded
                  :  Icons.delete_rounded,
                  color:
                    editingList.isEmpty
                    ? Colors.white
                    : Colors.redAccent,
                  size: 65,
                ),
              )
            ),
          ),
        ],
      ),
    
      body:ProductList(
        title: 'Carrito', 
        list: cart,
        addProductToEditingList: addProductToEditingList,
        deleteProductFromEditingList: deleteProductFromEditingList,
        ),
      floatingActionButton: 

        Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100,horizontal: 15),
                child: FadeInUp(
                  child: IconButton.filled(
                    onPressed: ()=>showDialog(
                      context: context, 
                      builder: (context) => AlertDialog(
                        title: const Text('Agregar Producto Manual'),
                        content: TextField(
                          controller: precioManual,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '350',
                            label: Text('Precio'),
                          ),
                        ),
                        actions: [
                          TextButton.icon(
                            icon: const Icon(Icons.add_rounded),
                            onPressed: (){
                              if(precioManual.text.isNotEmpty){
                                Product manual = Product(
                                  codigo: Random().nextInt(100).toString(), 
                                  descripcion: 'Suelto', 
                                  categoria: Category.categorias[6], 
                                  precio: precioManual.text
                                );

                                setState(() {
                                  cart.add(manual);
                                  cantidadProductos++;
                                  addToCategoryTotal(manual.categoria, manual.precio);
                                  calculateTotal();
                                  precioManual.text = '';
                                  context.pop();
                                });
                              }
                            }, 
                            label: const Text('Agregar'),
                            style: IconButton.styleFrom(backgroundColor: Colors.white),
                          )
                        ],
                      )
                    ), 
                    icon: const Icon(
                      Icons.edit_note_rounded,
                      size: 45,
                    ),
                    style: IconButton.styleFrom(backgroundColor: Colors.teal.shade900),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ConditionalButton(
                condition: editingList.isEmpty, 
                trueOnPressed: ()=>showDialog(
                  context: context, 
                  builder: (context) => AlertDialog(
                    title: const Text('Cobrar'),
                    actions: [
                      TextButton.icon(
                        icon: const Icon(Icons.phone_android_rounded),
                        onPressed: ()async{
                          if(cart.isNotEmpty){
                            totalTransferencia = total;
                            await addCartToRecord();
                            await resetEverything();
                          }
                        }, 
                        label: const Text('Transferencia'),
                        style: IconButton.styleFrom(backgroundColor: Colors.white),
                      ),
                      TextButton.icon(
                        icon: const Icon(Icons.payments_rounded),
                        onPressed: ()async {
                          if(cart.isNotEmpty){
                            totalEfectivo = total;
                            await addCartToRecord();
                            await resetEverything();
                          }
                        }, 
                        label: const Text('Efectivo'),
                        style: IconButton.styleFrom(backgroundColor: Colors.white),
                      )
                    ],
                  )
                ), 
                falseOnPressed: ()=>showDialog(
                  context: context, 
                  builder: (context)=> 
                  editingList.any((element) => int.parse(element) > 100)
                  ?AlertDialog(
                    title: const Text('Modificar cantidad'),
                    actions: [
                      IconButton.filled(
                        onPressed: (){
                          for(int i = 0; i<editingList.length; i++){
                          removeOneMoreFromCart(editingList[i]);
                          }
                        }, 
                        icon: const Icon(Icons.exposure_minus_1_rounded),
                      ),
                      IconButton.filled(
                        onPressed: (){
                          for(int i = 0; i<editingList.length; i++){
                            addItemToCart(editingList[i]);
                          }
                        }, 
                        icon: const Icon(Icons.plus_one_rounded),
                      ),
                    ],
                  )
                  :const AlertDialog(
                    title: Text('No se puede modificar productos sueltos'),
                  )
                ), 
                trueIcon: Icons.shopping_cart_checkout_rounded, 
                falseIcon: Icons.edit_rounded, 
                trueColor: Colors.white, 
                falseColor: Colors.white
              ),
            ),
          ],
        ),
    
      bottomNavigationBar: const BottomBar(currentPage: 1),
    );
  }
}
