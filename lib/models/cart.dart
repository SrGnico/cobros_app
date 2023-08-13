class Cart{

  final String fecha;
  final String cantidadVentas;
  final String total;
  final String totalTransferencia;
  final String totalEfectivo;
  final String cantidadProductos;
  final String almacenTotal;
  final String lacteosTotal;
  final String congeladosTotal;
  final String bebidasTotal;
  final String limpiezaTotal;
  final String perfumeriaTotal;
  final String sueltosTotal;

  Cart({
    required this.fecha,
    required this.cantidadVentas,
    required this.total, 
    required this.totalTransferencia, 
    required this.totalEfectivo, 
    required this.cantidadProductos, 
    required this.almacenTotal, 
    required this.lacteosTotal, 
    required this.congeladosTotal, 
    required this.bebidasTotal, 
    required this.limpiezaTotal, 
    required this.perfumeriaTotal,
    required this.sueltosTotal
  });


  factory Cart.fromJson(Map<String,dynamic> json) => Cart(
    fecha: json['fecha'], 
    cantidadVentas: json['cantidadVentas'],
    total: json['total'], 
    totalTransferencia: json['totalTransferencia'], 
    totalEfectivo: json['totalEfectivo'], 
    cantidadProductos: json['cantidadProductos'], 
    almacenTotal: json['almacenTotal'], 
    lacteosTotal: json['lacteosTotal'], 
    congeladosTotal: json['congeladosTotal'], 
    bebidasTotal: json['bebidasTotal'], 
    limpiezaTotal: json['limpiezaTotal'], 
    perfumeriaTotal: json['perfumeriaTotal'],
    sueltosTotal: json['sueltosTotal'],
  );

  Map<String,dynamic> toJson()=>{
    'fecha': fecha,
    'cantidadVentas': cantidadVentas,
    'total':total,
    'totalTransferencia': totalTransferencia,
    'totalEfectivo': totalEfectivo,
    'cantidadProductos': cantidadProductos,
    'almacenTotal':almacenTotal,
    'lacteosTotal':lacteosTotal,
    'congeladosTotal':congeladosTotal,
    'bebidasTotal':bebidasTotal,
    'limpiezaTotal':limpiezaTotal,
    'perfumeriaTotal': perfumeriaTotal,
    'sueltosTotal':sueltosTotal,
  };

}