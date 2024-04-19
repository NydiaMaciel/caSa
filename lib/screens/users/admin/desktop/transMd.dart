import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/data/transaccionesClass.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:demo_casa_3/services/sessions.dart';
import 'package:flutter/material.dart';

class TransMd extends StatefulWidget {
  Moderators usuario;
  String token;

  TransMd({super.key, required this.usuario, required this.token});

  @override
  State<TransMd> createState() => _TransMdState();
}

class _TransMdState extends State<TransMd> {
  TextEditingController _controller = TextEditingController();
  List<Transacciones> allTransactions = [];
  List<Transacciones> lista = [];
  bool isLoading = true;
  bool isEmpty = true;
  DateTime fechaSeleccionada = DateTime.now();

  @override
  void initState(){
    super.initState();
    fetchTransMD();
    setState(() {
      fechaSeleccionada = DateTime.now();
      lista = filterBYday();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.85,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    height: 30,width: 50,
                    child: MaterialButton(
                      onPressed: () => _seleccionarFecha(context),
                      child: Icon(Icons.calendar_month,color: Colors.white,),
                      color: appBarcolor3,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
              
                  if (fechaSeleccionada != null)
                    Container(
                      height: 30,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text('${fechaSeleccionada.day.toString().padLeft(2, '0')}-${fechaSeleccionada.month.toString().padLeft(2, '0')}-${fechaSeleccionada.year.toString()}'),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                        border: Border(
                          top: BorderSide(width: 0.8, color: Colors.grey, style: BorderStyle.solid),
                          bottom: BorderSide(width: 0.8, color: Colors.grey, style: BorderStyle.solid),
                          right: BorderSide(width: 0.8, color: Colors.grey, style: BorderStyle.solid),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Container(
              color: Colors.grey[200],
              height: MediaQuery.of(context).size.height*0.75,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: isEmpty? const Text('No se han registrado transacciones en este día.', style: TextStyle(fontSize: 17),):ListView.builder(
                itemCount: lista.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        ExpansionTile(
                          tilePadding: EdgeInsets.only(top: 5, bottom: 5, right: 10, left: 10),
                          childrenPadding: EdgeInsets.only(top: 0, bottom: 10, right: 10, left: 10),
                          title: Text(lista[index].rp_user, style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),), 
                          subtitle: Text(getFecha(lista[index].created_date)+' - '+getHora(lista[index].created_date),
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          children: [
                            ListTile(
                              title: const Text('Clientes referidos',style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )),
                              subtitle: Text(lista[index].clients_referred.toString(),style: TextStyle(fontSize: 17),),
                            ),
                          ]
                        ),
                      ],
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  String getFecha(DateTime date){
    String fecha = '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return fecha;
  }

  String getHora(DateTime date){
    String hora = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
    return hora;
  }

  List<Transacciones> filterBYday(){
    String sel = '${fechaSeleccionada.day.toString().padLeft(2, '0')}-${fechaSeleccionada.month.toString().padLeft(2, '0')}-${fechaSeleccionada.year.toString()}';
    List<Transacciones>liste = allTransactions.where((element){
      DateTime date= element.created_date;
      String data = '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString()}';
      return data.contains(sel);
    }).toList();
    setState(() {
      isEmpty = liste.length==0? true:false;
    });
    return liste;
  }

  Future<void> fetchTransMD()async{
    var jsonlist = await Services().getTransactionsModById(widget.token, widget.usuario.id);
    print(jsonlist.length.toString());
    List<Transacciones> tmp=[];
    if(jsonlist.length>0){
      for (var item in jsonlist){
        print(item['rp_user']);
        tmp.add(Transacciones.fromJson(item));
      }
      setState(() {
        allTransactions=tmp;
        isLoading = false;
      });
    }else{
      setState(() {
        isLoading = false;
      });
    }
  } 

  Future<void> _seleccionarFecha(BuildContext context) async {
    var fechaSelec = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      locale: const Locale('es'),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: color6, // Color principal (botones y resaltado)
            canvasColor: fucsia, // Color de fondo del selector de fechas
            dialogBackgroundColor: appBarcolor4,
            colorScheme: ColorScheme.light(primary: color6), // Color de la selección de fecha
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary), // Tema de los botones
          ),
          child: child!,
        );
      },
    );

    if (fechaSelec != null) {
      setState(() {
        fechaSeleccionada = fechaSelec;
        lista = filterBYday();
      });
    }
  }

}
