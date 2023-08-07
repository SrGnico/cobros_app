class Product {

  final String codigo;
  final String descripcion;
  final String categoria;
  final String precio;

  Product({
    required this.codigo, 
    required this.descripcion, 
    required this.categoria, 
    required this.precio
  });

  factory Product.fromJson(Map<String,dynamic> json) => Product(
    codigo: json['codigo'],
    descripcion: json['descripcion'],
    categoria: json['categoria'],
    precio: json['precio']
  );

  Map<String, dynamic> toJson() =>{
    'codigo': codigo,
    'descripcion': descripcion,
    'categoria': categoria,
    'precio': precio
  };

}