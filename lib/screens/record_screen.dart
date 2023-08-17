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
  DateTime selectedDate = DateTime.now();
  String title = 'Todos';
  
  _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    helpText: 'Seleccione una fecha',
    cancelText: 'Limpiar',
    confirmText: 'Aplicar',
    initialDate: selectedDate, 
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    firstDate: DateTime(2023),
    lastDate: DateTime(2030),
    
  );
  if (picked != null){
    setState(() {
      String selectdDay = picked.day.toString();
      String selectdMonth = picked.month.toString();
      String selectdYear = picked.year.toString();

      String searchDate = '$selectdDay/$selectdMonth/$selectdYear';
      list = DatabaseRecord.getRecordByDate(searchDate);
      title = searchDate;
    });
  }
  if(picked == null){
    setState(() {
      title = 'Todos';
      list = DatabaseRecord.getAllRecords();
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Registro',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
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
            child:IconButton(
              style: IconButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () => _selectDate(context),
              icon: const Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.calendar_month_rounded,
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