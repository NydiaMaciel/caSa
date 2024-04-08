import 'package:demo_casa_3/screens/data/productosClass.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

final List<Productos> lista = productoslista;
final TextEditingController ctrl_nombre = new TextEditingController();
final TextEditingController ctrl_precio = new TextEditingController();

class ProductosTab extends StatefulWidget {
  @override
  _ProductosTab createState()=> _ProductosTab();
}

class _ProductosTab extends State <ProductosTab>{
  bool sortAscending = true;
  bool editflag = false;

  onSortColumn(int colIndex, bool ascending){
    if(colIndex==0){
      if(ascending){
        lista.sort((a,b)=>a.Nombre.compareTo(b.Nombre));
      }else{
        lista.sort((a,b)=>b.Nombre.compareTo(a.Nombre));
      }
    }else if(colIndex==0){
      if(ascending){
        lista.sort((a,b)=>a.Precio.compareTo(b.Precio));
      }else{
        lista.sort((a,b)=>b.Precio.compareTo(a.Precio));
      }
    }
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(iconAdd),
        elevation:5.0,
        onPressed: ()async{
          await showDialog<void>(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Agregar producto'),
              content: SizedBox(
                height: 150,
                child: Column(
                  children: [
                    TextFormField(
                      controller: ctrl_nombre,
                      decoration: InputDecoration(
                        labelText: 'Producto',
                        labelStyle: const TextStyle(fontSize: 14),
                        enabled: true,
                      ),
                    ),
                    TextFormField(
                      controller: ctrl_precio,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.{0,1}\d{0,2}$'))],
                      decoration: InputDecoration(
                        labelText: 'Precio',
                        labelStyle: const TextStyle(fontSize: 14),
                        suffixIcon: Icon(iconPesos,size: 20,),
                        enabled: true,
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                FilledButton.tonal(
                  child: const Text('Cancelar'),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                ),
                FilledButton(
                  child: const Text('Agregar'),
                  onPressed: (){
                    setState(() {
                      if(ctrl_nombre.text!='' && ctrl_precio.text!=''){
                        List<Productos> tmp = lista;
                        tmp.sort((a, b) => a.ID.compareTo(b.ID));
                        int mayor = !(tmp[0].ID>tmp[tmp.length-1].ID)?tmp[tmp.length-1].ID:tmp[0].ID;
                        lista.add(Productos(ID: mayor+1, Nombre: ctrl_nombre.text, Precio: double.parse(ctrl_precio.text), edit: false));
                      }
                      ctrl_nombre.text='';
                      ctrl_precio.text='';
                      Navigator.of(context).pop();
                    });
                  }, 
                ),
              ],
            )
          );
        },
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Text('Productos',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            SizedBox(height: 20),
            Container(
              height:MediaQuery.of(context).size.height*0.80,
              child: SingleChildScrollView(
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text('Producto'),
                      tooltip: 'Producto',
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          //
                        });
                      },
                    ),
                    DataColumn(
                      label: Text('Precio'),
                      tooltip: 'Precio',
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          //
                        });
                      },
                    ),
                    DataColumn(
                      label: Text('Editar/Eliminar'),
                      tooltip: 'Ediar/Eliminar producto'
                    )
                  ], 
                  rows: lista.map<DataRow>((Productos data){
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(
                          !data.edit? Text(data.Nombre):TextFormField(
                            decoration: InputDecoration(border: InputBorder.none,),
                            initialValue: data.Nombre,
                            keyboardType: TextInputType.name,
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black87),
                            readOnly: !data.edit,
                            onChanged: (value) {
                              setState(() {
                                data.Nombre=value;
                              });
                            },
                          ),
                          showEditIcon: data.edit,
                        ),
                        DataCell(
                          !data.edit? Text('\$'+data.Precio.toString()):TextFormField(
                            decoration: InputDecoration(border: InputBorder.none,),
                            initialValue: data.Precio.toString(),
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black87),
                            readOnly: !data.edit,
                            onChanged: (value) {
                              setState(() {
                                data.Precio=double.parse(value);
                              });
                            },
                          ),
                          showEditIcon: data.edit,
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: data.edit? Icon(iconEdit,size: 17,color: Colors.green,):Icon(iconEdit,size: 17),
                                onPressed: (){
                                  setState(() {
                                    data.edit=!data.edit;
                                  });
                                }, 
                              ),
                              IconButton(
                                icon: Icon(Icons.delete,size: 17,color: const Color.fromARGB(255, 138, 37, 30),),
                                onPressed: () {
                                  setState(() {
                                    lista.removeWhere((item) => item.ID == data.ID);
                                  });
                                },
                              ),
                            ],
                          )
                        )
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
            //SizedBox(height: 500,)
          ],
        ),
      ),
    );
  } 
}
