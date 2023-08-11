import 'package:cobros_app/models/category_colors.dart';
import 'package:cobros_app/models/category_icons.dart';
import 'package:cobros_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FutureProductItem extends StatefulWidget {
  Function addProductToEditingList;
  Function deleteProductFromEditingList;
  final Product product;

  FutureProductItem({
    super.key, 
    required this.product,
    required this.addProductToEditingList,
    required this.deleteProductFromEditingList
  });

  @override
  State<FutureProductItem> createState() => _FutureProductItemState();
}

class _FutureProductItemState extends State<FutureProductItem> {


  final colores = CategoryColor.colores;

  final icons = CategoryIcon.icons;

  final ScrollController _controller = ScrollController();

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {

    // TODO: ver como editar todos los selecionados y crear un dialog tal vez para cambiar el precio?
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 52,
            child: ListView(
              physics: null,
              controller: _controller,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onLongPress: () {
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
                  child: SizedBox(
                    width: (MediaQuery.of(context).size.width - 36) ,
                    height: 52,
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
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.product.descripcion,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25
                            ),
                            ),
                            Text(widget.product.categoria,
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20
                            ),  
                            )
                          ],
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