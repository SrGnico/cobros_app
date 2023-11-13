import 'package:cobros_app/models/category.dart';
import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/services/database_product.dart';
import 'package:cobros_app/widgets/button/conditional_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddOrEditProductScreen extends StatefulWidget {
  final Product editingProduct;

  const AddOrEditProductScreen({required this.editingProduct, super.key});

  @override
  State<AddOrEditProductScreen> createState() => _AddOrEditProductScreenState();
}

class _AddOrEditProductScreenState extends State<AddOrEditProductScreen> {
  var descripcionController = TextEditingController();
  var precioController = TextEditingController();
  var codigoController = TextEditingController();
  final categorias = Category.categorias;

  bool isEditing = false;

  String selectedCategoria = 'Almacen';

  @override
  void initState() {
    if (widget.editingProduct.codigo != '') {
      isEditing = true;
      selectedCategoria = widget.editingProduct.categoria;
      descripcionController.text = widget.editingProduct.descripcion;
      precioController.text = widget.editingProduct.precio;
      codigoController.text = widget.editingProduct.codigo;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        toolbarHeight: 150,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Productos',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isEditing ? 'Editar' : 'Agregar',
              maxLines: 1,
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 50, 10, 0),
              child: ConditionalButton(
                  condition: isEditing,
                  trueOnPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Eliminar producto'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                context.pop();
                                context.pop();
                              },
                              child: const Text('Cancelar')),
                          TextButton(
                              onPressed: () {
                                Product product = Product(
                                    codigo: codigoController.text,
                                    descripcion: descripcionController.text,
                                    categoria: selectedCategoria,
                                    precio: precioController.text);
                                DatabaseHelper.deleteProduct(product);
                                context.push('/product');
                              },
                              child: const Text('Eliminar')),
                        ],
                      ),
                    );
                  },
                  falseOnPressed: () async {
                    var res = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const SimpleBarcodeScannerPage(),
                        ));
                    setState(() {
                      if (res is String) {
                        codigoController.text = res;
                      }
                    });
                  },
                  trueIcon: Icons.delete_rounded,
                  falseIcon: Icons.qr_code_scanner_rounded,
                  trueColor: Colors.redAccent,
                  falseColor: Colors.white)),
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
                  hintText: 'Arvejas Inalpa 300g'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: codigoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Codigo'),
                  hintText: '779...'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: precioController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Precio'),
                  hintText: '350'),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Text(
                'Categoria',
                style: TextStyle(fontSize: 25),
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
                      onChanged: (value) {
                        setState(() {
                          selectedCategoria = value!;
                        });
                      });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
          style: IconButton.styleFrom(backgroundColor: Colors.teal),
          onPressed: () {
            Product product = Product(
                codigo: codigoController.text,
                descripcion: descripcionController.text,
                categoria: selectedCategoria,
                precio: precioController.text);

            if (product.codigo.isEmpty &&
                product.descripcion.isEmpty &&
                product.precio.isEmpty) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Faltan campos por agregar!'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          context.pop();
                          context.pop();
                        },
                        child: const Text('Cancelar')),
                    TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: const Text('Volver')),
                  ],
                ),
              );
              return;
            }
            isEditing
                ? DatabaseHelper.updateProduct(product)
                : DatabaseHelper.addProduct(product);

            codigoController.text = '';
            descripcionController.text = '';
            precioController.text = '';
            context.push('/product');
          },
          icon: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 65,
            ),
          )),
    );
  }
}
