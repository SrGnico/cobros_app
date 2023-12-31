import 'package:cobros_app/models/category.dart';
import 'package:cobros_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ItemList extends StatefulWidget {
  final Function addProductToEditingList;
  final Function deleteProductFromEditingList;
  final Product product;

  const ItemList({
    super.key, 
    required this.product,
    required this.addProductToEditingList,
    required this.deleteProductFromEditingList
  });

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  final colores = CategoryColor.colores;

  final icons = CategoryIcon.icons;

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 52,
            child: ListView(
              physics: null,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: (){
                    HapticFeedback.vibrate();
                    setState(() {
                      isSelected = !isSelected;
                      if(isSelected){
                        widget.addProductToEditingList(widget.product.codigo.toString());
                      }
                      else{
                        widget.deleteProductFromEditingList(widget.product.codigo.toString());
                      }
                    });
                  },
                  onLongPress: () {
                    context.pushNamed('addOrEdit',extra: widget.product);
                  },
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width - 36) ,
                    height: 60,
                    child: Row(
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(20),
                          enableFeedback: true,
                          onTap: () {
                            HapticFeedback.vibrate();
                            setState(() {
                              isSelected = !isSelected;
                              if(isSelected){
                                widget.addProductToEditingList(widget.product.codigo.toString());
                              }
                              else{
                                widget.deleteProductFromEditingList(widget.product.codigo.toString());
                              }
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color:isSelected ? Colors.teal : colores[widget.product.categoria] ,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Icon( isSelected? Icons.check_rounded : icons[widget.product.categoria],
                                color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: (MediaQuery.of(context).size.width/1.8),
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 1,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  child: Text(widget.product.descripcion,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                  ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Text(widget.product.categoria,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18
                                ),  
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$ ${widget.product.precio}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 30
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Divider(height: 0.1),
        )
      ],
    );
  }
}