import 'dart:convert';
import 'package:toastification/toastification.dart';
import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:flutter/material.dart';

class ModsMobile extends StatefulWidget{
  String token;
  ModsMobile({super.key, required this.token});
  @override
  _ModsMobile createState()=>_ModsMobile();
}


class _ModsMobile extends State<ModsMobile> {
  double alt=40;
  TextEditingController ctrl_nombre = new TextEditingController();
  TextEditingController ctrl_contra = new TextEditingController();
  TextEditingController ctrl_email = new TextEditingController();
  TextEditingController ctrl_query = new TextEditingController();
  bool iconSearchBarCancel=false;
  late List<Moderators> allModerators;
  late List<Moderators> filteredModerators;
  bool isLoading = true;
  bool errorHttp = false;
  String errorAdvice='';

  @override
  void initState() {
    super.initState();
    fetchModerators();
  }

  List<Moderators> filter (String query){
    final cards = allModerators.where((element) {
      String lowerName = element.userName.toLowerCase();
      String lowerQuery = query.toLowerCase();
      return lowerName.contains(lowerQuery);
    }).toList();
    return cards;
  }

  Future<void> fetchModerators()async{
    var jsonlist = await Services().getAllModerators(widget.token);
    List<Moderators> tmp=[];
    for (var item in jsonlist){
      print(item["user_name"]+' - '+item['id'].toString());
      tmp.add(Moderators.fromJson(item));
    }
    setState(() {
      allModerators=tmp;
      filteredModerators=tmp;
      isLoading = false;
    });
  }
    
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
      child: Icon(iconAdd,color: color1,),
      backgroundColor: appBarcolor,
      elevation:5.0,
      onPressed: (){
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (BuildContext context){
            return AlertDialog(
              backgroundColor: BGformFull,
              insetPadding: EdgeInsets.all(20),
              content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState){
                  return Container(
                    height:180,
                    width:MediaQuery.of(context).size.width*0.7,
                    child: Column(
                      children: [
                        Text('Registrar nuevo moderator',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: ctrl_nombre,
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                            labelStyle: TextStyle(fontSize: 14),
                            enabled: true,
                          ),
                          onChanged: (value){
                            setState((){
                              if(errorHttp){
                                errorHttp=false;
                                errorAdvice="";
                              }
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: ctrl_email,
                          decoration: const InputDecoration(
                            labelText: 'Correo electrónico',
                            labelStyle: TextStyle(fontSize: 14),
                            enabled: true,
                          ),
                        ),
                        //generar contraseña aleatoria y enviarla al correo proporcionado 
                      ],
                    )
                  );
                },
              ),
              actions: [
              FilledButton(
                child: Text('Cancelar',style: TextStyle(color: fucsiaDark),),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(fucsiaTonal),
                  shape:MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(width: 1.0,color: fucsiaTonalDark), )
                  ),                
                ),
                onPressed: (){
                  setState(() {
                    ctrl_nombre.text="";
                    ctrl_email.text="";
                    ctrl_contra.text="";
                    errorHttp=false;
                    Navigator.of(context).pop();
                  });
                }, 
              ),
              FilledButton(
                child: Text('Agregar'),
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(fucsia)),
                onPressed: ()async{
                  var response;
                  try{
                    response = await Services().createMod(ctrl_nombre.text, ctrl_email.text, ctrl_email.text, widget.token);
                    print('create.CODE:'+response.statusCode.toString());
                    if (response.statusCode==201){
                      errorHttp=false;
                      setState(() {
                        //limpia variables
                        ctrl_nombre.text="";
                        ctrl_email.text="";
                        ctrl_contra.text="";
                        errorHttp = true;
                        errorAdvice='';
                      });
                      Navigator.of(context).pop();
                    }else if (response.statusCode==409){
                      setState(() {
                        print('ERROR ${response.statusCode}.${response.body}');
                        warning();
                      });
                    }
                  }catch(e){
                    setState(() {
                      print('ERROR: $e !!!');
                    });
                    Navigator.of(context).pop();
                  }
                }, 
              ),
            ],
            );
          },
        );
      },
    ),
      //************************************************************************** */
      //************************************************************************** */
      //************************************************************************** */
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            height: 50,
            child: TextField(
              controller: ctrl_query,
              style: TextStyle(fontSize: 16),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5),
                labelStyle: TextStyle(fontSize: 5),
                prefixIcon: const Icon(Icons.search,size: 25,),
                suffixIcon: iconSearchBarCancel? IconButton(
                  icon: Icon(iconX,size: 17,),
                  onPressed: (){
                    setState(() {
                      ctrl_query.text="";
                      filteredModerators=allModerators;
                      iconSearchBarCancel=false;
                    });
                  }, 
                ):null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: const BorderSide(color: Color.fromARGB(255, 255, 112, 193),width: 1.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  if(value==""){
                    filteredModerators=allModerators;
                    iconSearchBarCancel=false;
                  }else{
                    iconSearchBarCancel=true;
                    filteredModerators=filter(value);
                  }
                });
              },
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.77,
            //constraints: BoxConstraints(minWidth:1265.6, minHeight:0.0,maxHeight:double.infinity),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: filteredModerators.length,
              itemBuilder: (context,index){
                return ExpansionTile(
                  iconColor: color6,
                  tilePadding: EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
                  childrenPadding: EdgeInsets.only(top: 0, bottom: 20, right: 50, left: 40),
                  title: Text(filteredModerators[index].userName, style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text('Correo electrónico', style: TextStyle(fontWeight: FontWeight.w600,)),
                      subtitle: Text(filteredModerators[index].email,style: TextStyle(fontSize: 17),),
                    ),
                    Container(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.bottomRight,
                      child: FilledButton.tonal(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 209, 203)),
                        ),
                        child: Text('Eliminar',style: TextStyle(color: Color.fromARGB(255, 221, 47, 35)),),
                        onPressed: ()async{
                          var response = await Services().deleteMod(filteredModerators[index].id, widget.token);
                          fetchModerators();
                        }, 
                      ),
                    ),
                  ],

                  
                       
                  
                  //
                );
              },
            ),
          ),
        ],
      ),
    ); 
  }

  void warning(){
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: highModeShadow,
      showProgressBar: false,
      title: Text('Usuario existente ',style: TextStyle(fontSize: 18),),
      description: Text('El nombre de usuario ya ha sido registrado.',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
    );
  }
  
}