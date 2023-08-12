import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/services/database_delper.dart';
import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:cobros_app/widgets/cart/product_list.dart';
import 'package:flutter/material.dart';
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

  void addItemToCart(String codigo) async {
    List<Product> lista = await DatabaseHelper.getProductByCodigo(codigo);

    Product item = lista[0];

    var exists = cart.where((element) => element.codigo == item.codigo);

    if(exists.isNotEmpty){
      print('yala');
      addOneMoreToCart(item.codigo, item.precio);
      setState(() {
        calculateTotal();
      });
    }
    else{
      setState(() {
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
  final index = cart.indexWhere((item) => item.codigo == codigo );
  int nuevoPrecio = int.parse(cart[index].precio) + int.parse(precioOriginal);
  cart[index] = Product(
    codigo: cart[index].codigo, 
    descripcion: cart[index].descripcion, 
    categoria: cart[index].categoria, 
    precio: nuevoPrecio.toString(),
    );

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
              onPressed: editingList.isEmpty
              ?() async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String){
                    addItemToCart(res);
                  }
                });
              }
              :(){
                for(int i = 0; i<editingList.length; i++){
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
                    ? Colors.teal
                    :Colors. red,
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
        IconButton(
          onPressed: () {
              //TODO implementar funcionalidades al boton
          }, 
        icon: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            editingList.isEmpty
            ? Icons.shopping_cart_checkout_rounded
            : Icons.edit_rounded,
            color: Colors.teal,
            size: 65,
            ),
          )
        ),
      bottomNavigationBar: const BottomBar(currentPage: 1),
    );
  }
}
