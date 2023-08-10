import 'package:cobros_app/models/category.dart';
import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/services/database_delper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';


class AddProductScreen extends StatefulWidget {

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  var descripcionController = TextEditingController();
  var precioController = TextEditingController();
  var codigoController = TextEditingController();
  final categorias = Category.categorias;


  String selectedCategoria = 'Almacen';
  
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

   

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Productos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Agregar',
              maxLines: 1,
              style: TextStyle(
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
              onPressed: () async {
                var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SimpleBarcodeScannerPage(),
                    ));
                setState(() {
                  if (res is String) {
                    codigoController.text = res;
                  }
                });
              },
              icon: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  color: Colors.teal,
                  size: 65,
                ),
              )
            ),
          ),
        ],
       
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Descripcion'),
                hintText: 'Arvejas Inalpa 300g'
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: codigoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Codigo'),
                hintText: '779...'
              ),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: precioController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Precio'),
                hintText: '350'
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 0),
              child: Text('Categoria',
                style: TextStyle(
                  fontSize: 25
                ),
              ),
            ),

            const SizedBox(height: 10),
          
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    value: categorias[index].toString(), 
                    title: Text(categorias[index].toString()),
                    groupValue: selectedCategoria, 
                    onChanged: (value){
                      setState(() {
                        selectedCategoria = value!;
                      });
                    }
                  );
                },
              ),
            ), 
          
          ],
        ),
      ),

      floatingActionButton: 
        IconButton(
          onPressed:(){
            Product product = Product(
              codigo: codigoController.text, 
              descripcion: descripcionController.text, 
              categoria: selectedCategoria, 
              precio: precioController.text
            );

            if(product.codigo.isEmpty && product.descripcion.isEmpty && product.precio.isEmpty) {
              showDialog(context: context, 
                builder: (context) => AlertDialog(
                  title: const Text('Faltan campos por agregar!'),
                  actions: [
                    TextButton(
                      onPressed: (){
                        context.pop();
                        context.pop();

                      }, 
                      child: const Text('Cancelar')),
                    TextButton(
                      onPressed: (){
                        context.pop();
                      }, 
                      child: const Text('Volver')
                    ),
                  ],
                ),
              );
              return;
            }
    
            DatabaseHelper.addProduct(product);
            context.pop();
          }, 
          icon: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.check_rounded,
              color: Colors.teal,
              size: 65,
              ),
            )
          ),

    );
  }
}