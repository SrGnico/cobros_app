import 'package:cobros_app/models/cart.dart';
import 'package:cobros_app/services/database_record.dart';
import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:cobros_app/widgets/record/record_list.dart';
import 'package:flutter/material.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {


  Future<List<Cart>?> list = DatabaseRecord.getAllRecords();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Registro',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Todos',
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
            child:IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () => showDialog(
                context: context,
                builder: (context) =>AlertDialog(
                  title: const Text('Filtrar o buscar'),
                  content: const Text('AVE'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: (){
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
      body: RecordList(list: list),
      bottomNavigationBar:const  BottomBar(currentPage: 0),
    );
  }
}