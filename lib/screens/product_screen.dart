import 'package:cobros_app/models/category.dart';
import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/services/database_product.dart';
import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:cobros_app/widgets/button/conditional_button.dart';
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

  final _nuevoPrecio = TextEditingController();
  final _search = TextEditingController();

  List<String> editingList = [];


  void getProductBySearch(){
    setState(() {
      list = DatabaseHelper.getProductBySearch(_search.text);
      selectedCategoria = _search.text;
      _search.text = '';
      context.pop();
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

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
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
              style: IconButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () => showDialog(
                context: context,
                builder: (context) =>AlertDialog(
                  title: const Text('Filtrar o buscar'),
                  content: SingleChildScrollView(
                    child: SizedBox(
                      height:height/ 2,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              width: width,
                              child: TextField(
                                controller: _search,
                                onSubmitted: (value) => getProductBySearch(),
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: IconButton(
                                      onPressed:()=> getProductBySearch(),
                                      icon: const Icon(Icons.search_rounded)),
                                  ),
                                  border:const  OutlineInputBorder(),
                                  label: const Text('Buscar'),
                                ),
                              ),
                            ),
                            const Divider(),
                            const Text('Filtrar por categoria',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20
                            ),
                            ),
                            SingleChildScrollView(
                              child: SizedBox(
                                height:height /2.75,
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
                            ),
                          ],
                        ),
                      ),
                    ),
                  ), 
                  actions: <Widget>[
                    TextButton(
                      onPressed: (){
                        setState(() {
                          _search.text = '';
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
                  color: Colors.white,
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
        ConditionalButton(
          condition: editingList.isEmpty, 
          trueOnPressed: (){
            Product emptyProduct = Product(codigo: '', descripcion: '', categoria: '', precio: '');
            context.pushNamed('addOrEdit', extra:emptyProduct);
          }, 
          falseOnPressed: (){
            showDialog(context: context, 
              builder: (context) => AlertDialog(
                title: const Text('Actualizar precios'),
                content: TextField(
                  controller: _nuevoPrecio,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text('Nuevo precio'),
                    border:  OutlineInputBorder(),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: ()async{
                      if(_nuevoPrecio.text.isNotEmpty){
                        await DatabaseHelper.updatePrices(editingList, _nuevoPrecio.text);
                        setState(() {
                          _nuevoPrecio.text = '';
                          editingList = [];
                          list = DatabaseHelper.getAllProducts();
                          context.pop();
                        });
                      }
                    }, 
                    child: const Text('Guardar')
                  )
                ],
              ),
            );
          }, 
          trueIcon: Icons.add, 
          falseIcon: Icons.price_change_rounded, 
          trueColor: Colors.white, 
          falseColor: Colors.white
        ),
      bottomNavigationBar: const BottomBar(currentPage: 2),
    );
  }
}