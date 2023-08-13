import 'package:cobros_app/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  content: SingleChildScrollView(
                    child: SizedBox(
                      height:height/2,
                      width: width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              width: width,
                              child: TextField(
                                controller: null, //_search,
                                onSubmitted: (value){ 
                                  // getProductBySearch()
                                },
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 3),
                                    child: IconButton(
                                      onPressed:(){
                                        //getProductBySearch(),

                                        },
                                      icon: const Icon(Icons.search_rounded)),
                                  ),
                                  border:const  OutlineInputBorder(),
                                  label: const Text('Buscar'),
                                ),
                              ),
                            ),
                            const Divider(),
                            const Text('Filtrar por categoria',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20
                            ),
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: null , //categorias.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return const SizedBox();
                                /*
                                return RadioListTile<String>(
                                  value: categorias[index].toString(), 
                                  title: Text(categorias[index].toString()),
                                  groupValue: selectedCategoria, 
                                  onChanged: (value){
                                    setState(() {
                                      selectedCategoria = value!;
                                      list = DatabaseHelper.getProductByCategoria(selectedCategoria.toString());
                                    });
                                    context.pop();
                                  }
                                );
                                */
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ), 
                  actions: <Widget>[
                    TextButton(
                      onPressed: (){
                        /*
                        setState(() {
                          _search.text = '';
                          selectedCategoria = '';
                          list = DatabaseHelper.getAllProducts();
                          context.pop();
                        });
                        */
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
      body:const  Center(child: Text('Record Screen')),
      bottomNavigationBar:const  BottomBar(currentPage: 0),
    );
  }
}