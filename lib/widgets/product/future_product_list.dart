import 'package:cobros_app/models/product.dart';
import 'package:cobros_app/widgets/item/item_list.dart';
import 'package:flutter/material.dart';

class FutureProductList extends StatelessWidget {

  final Function addProductToEditingList;
  final Function deleteProductFromEditingList;


  final Future<List<Product>?> list;
  final String? title;
  const FutureProductList({
    required this.addProductToEditingList,
    required this.deleteProductFromEditingList,
    super.key, 
    this.title, 
    required this.list
  });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        (title != '')? const SizedBox():
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(title!,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: list,
            builder: (context,AsyncSnapshot<List<Product>?> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return ItemList(
                      addProductToEditingList: addProductToEditingList,
                      deleteProductFromEditingList: deleteProductFromEditingList,
                      product: item
                    );
                  },
                );
              }
              else{return const Center(child: Text('No se han encontrado resultados!'));}
            },
          ),
        ),
      ],
    );
  }
}