import 'package:cobros_app/models/cart.dart';
import 'package:cobros_app/models/category.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';


class RecordItem extends StatefulWidget {
  final Cart cart;
  const RecordItem({
    super.key,
    required this.cart
    });

  @override
  State<RecordItem> createState() => _RecordItemState();
}

class _RecordItemState extends State<RecordItem> {

  @override
  Widget build(BuildContext context) {


    Map<String,double>chartMap = {
      'Almacen': double.parse(widget.cart.almacenTotal),
      'Lacteos': double.parse(widget.cart.lacteosTotal),
      'Congelados': double.parse(widget.cart.congeladosTotal),
      'Bebidas': double.parse(widget.cart.bebidasTotal),
      'Limpieza': double.parse(widget.cart.limpiezaTotal),
      'Perfumeria': double.parse(widget.cart.perfumeriaTotal),
      'Suelto': double.parse(widget.cart.sueltosTotal)
    };

    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(
        widget.cart.fecha,
        style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 25
      ),),
      subtitle: Text('${widget.cart.cantidadVentas} Ventas - ${widget.cart.cantidadProductos} Productos',
        style: const TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 20
        ),  
      ),
      trailing: Text(
        '\$ ${widget.cart.total}',
        style: const TextStyle(
          color: Colors.green,
          fontSize: 30
        ),
      ),
      children: [
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('\$ ${widget.cart.totalEfectivo} en efectivo',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.blueGrey
              ),
            ),
            Text('\$ ${widget.cart.totalTransferencia} en transferencia',
             style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.blueGrey
              ),
            ),
          ],
        ),
        const Divider(),

        PieChart(
          colorList: CategoryColor.list,
          dataMap: chartMap,
          chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
        )
      ],
    );
  }
}