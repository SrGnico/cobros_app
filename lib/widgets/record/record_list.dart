import 'package:cobros_app/models/cart.dart';
import 'package:cobros_app/widgets/record/record_item.dart';
import 'package:flutter/material.dart';

class RecordList extends StatelessWidget {

  final Future<List<Cart>?> list;

  const RecordList({
    super.key,
    required this.list
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Expanded(
          child: FutureBuilder(
            future: list,
            builder: (context,AsyncSnapshot<List<Cart>?> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator());
              }
              if(snapshot.hasData){
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final item = snapshot.data![index];
                    return RecordItem(cart:item);
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