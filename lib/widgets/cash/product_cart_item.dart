import 'package:cobros_app/models/category_colors.dart';
import 'package:cobros_app/models/category_icons.dart';
import 'package:cobros_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductCartItem extends StatefulWidget {
  final Product product;

  const ProductCartItem({super.key, required this.product});

  @override
  State<ProductCartItem> createState() => _ProductCartItemState();
}

class _ProductCartItemState extends State<ProductCartItem> {
  final colores = CategoryColor.colores;

  final icons = CategoryIcon.icons;

  final ScrollController _controller = ScrollController();

  bool isSelected = false;

  void _scrollToEnd(){
    if(_controller.position.maxScrollExtent != _controller.position.pixels){
      _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      );
    }
    else{
      _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.elasticOut,
      );
    }
   
  }

  @override
  Widget build(BuildContext context) {

    // TODO: BOTONES Y EDICION
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
                  onTap: _scrollToEnd,
                  onLongPress: () {
                    setState(() {
                      isSelected = !isSelected;
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
                          '+ \$ ${widget.product.precio}',
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 30
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                IconButton.filled(
                  onPressed: (){}, 
                  icon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.exposure_minus_1_rounded),
                  ),
                ),
                const SizedBox(width: 5),
                IconButton.filled(
                  onPressed: (){}, 
                  icon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.exposure_plus_1_rounded),
                  ),
                ),
                const SizedBox(width: 5),
                IconButton.filled(
                  onPressed: (){}, 
                  icon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.edit_rounded),
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
//todo: BOTONES DE ESTA PARTE
/* 
const SizedBox(width: 5),
                IconButton.filled(
                  onPressed: (){}, 
                  icon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.exposure_minus_1_rounded),
                  ),
                ),
                const SizedBox(width: 5),
                IconButton.filled(
                  onPressed: (){}, 
                  icon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.exposure_plus_1_rounded),
                  ),
                ),
                const SizedBox(width: 5),
                IconButton.filled(
                  onPressed: (){}, 
                  icon: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Icon(Icons.edit_rounded),
                  ),
                ),
*/