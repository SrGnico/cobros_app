import 'package:cobros_app/models/category.dart';
import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/services/database_delper.dart';
import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:cobros_app/widgets/product/future_product_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductScreen extends StatefulWidget {

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {

  final categorias = Category.categorias;
  String selectedCategoria = '';

  Future<List<Product>?> list = DatabaseHelper.getAllProducts();


  List<String> editingList = [];

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

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
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
              selectedCategoria == '' ? 'Todos' : selectedCategoria,
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
              onPressed: () => showDialog(
                context: context,
                builder: (context) =>AlertDialog(
                  title: const Text('Filtrar por categoria'),
                  content: SizedBox(
                    height:height/2,
                    width: width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: categorias.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return RadioListTile<String>(
                          value: categorias[index].toString(), 
                          title: Text(categorias[index].toString()),
                          groupValue: selectedCategoria, 
                          onChanged: (value){
                            setState(() {
                              selectedCategoria = value!;
                              list = DatabaseHelper.getProductByCategoria(selectedCategoria.toString());
                            });
                            context.pop();

                          }
                        );
                      },
                    ),
                  ), 
                  actions: <Widget>[
                    TextButton(
                      onPressed: (){
                        setState(() {
                          selectedCategoria = '';
                          list = DatabaseHelper.getAllProducts();
                          context.pop();
                        });
                      },
                      child: const Text('Limpiar filtros'),
                    ),
                   
                  ],
                )
                
              ),
              icon: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.sort_by_alpha_rounded,
                  color: Colors.teal,
                  size: 65,
                ),
              )
            ),
          ),
        ],
      ),
      body: FutureProductList(
        list: list,
        addProductToEditingList: addProductToEditingList,
        deleteProductFromEditingList: deleteProductFromEditingList,
        ),
      floatingActionButton: 
        IconButton(
          onPressed: () {
            //TODO IMPLEMENT EDIT SCREEN OR SEE WHAT TO DO
            editingList.isEmpty ? context.goNamed('add') : context.goNamed('edit');
          }, 
          icon: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              editingList.isEmpty ? Icons.add : Icons.edit_rounded,
              color: Colors.teal,
              size: 65,
              ),
            )
          ),
      bottomNavigationBar: const BottomBar(currentPage: 2),
    );
  }
}