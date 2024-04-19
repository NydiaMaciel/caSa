import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/transMd.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

//
TextEditingController ctrl_nombre = new TextEditingController();
TextEditingController ctrl_contra = new TextEditingController();
TextEditingController ctrl_email = new TextEditingController();
TextEditingController ctrl_query = new TextEditingController();
bool iconSearchBarCancel=false;

class ModeradoresMD extends StatefulWidget {
  String token;
  ModeradoresMD({super.key,required this.token});

  @override
  State<ModeradoresMD> createState() => _ModeradoresMDState();
}

class _ModeradoresMDState extends State<ModeradoresMD> {
  bool sortAscending = true;
  bool editflag = false;
  bool isLoading = true;
  bool errorHttp = false;
  int selectedPanel = -1;
  Color tileSelectedColor = Colors.white;
  Color checkColor = Color.fromARGB(255, 51, 72, 135);
  late List<Moderators> allModerators;
  late List<Moderators> filteredModerators;
  late Widget userDataPanel;
  String errorAdvice='';
  double drawerSize = 250;
  bool showPanel = false;
  Icon openPanel = Icon(Icons.arrow_forward_ios,size: 17,color: color1);
  Icon closePanel = Icon(Icons.arrow_back_ios,size: 17,color: color6);

  onSortColumn(int colIndex, bool ascending){
    if(colIndex==0){
      if(ascending){
        //lista.sort((a,b)=>a.nombre.compareTo(b.nombre));
      }else{
        //lista.sort((a,b)=>b.nombre.compareTo(a.nombre));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchModerators();
    userDataPanel=Container();
  }

  List<Moderators> filter (String query){
    var  cards = allModerators.where((element) {
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
      return Scaffold(
        body: Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width-drawerSize)/2,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 3,strokeAlign: 5,),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: (MediaQuery.of(context).size.width-drawerSize)/2,
              color: colorPanelEmpty,
            ),
          ],
        ),
      );
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(iconAdd,color: color1,),
        backgroundColor: appBarcolor,
        elevation:5.0,
        onPressed: (){
          addModDialog();
        },
      ),
      body: Container(
        width: MediaQuery.of(context).size.width-drawerSize,
        child: Row(
          children: [
            Container(
              width: (MediaQuery.of(context).size.width-drawerSize)/2,
              child: Column(
                children: [
                  buscador(),
                  Container(
                    height: MediaQuery.of(context).size.height-70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 0.8, color: appBarcolorx,),
                        top: BorderSide(width: 0.5, color: Colors.grey,)
                      ),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: filteredModerators.length,
                      itemBuilder:(context,index){
                        return ListTile(
                          title: Text(filteredModerators[index].userName),
                          hoverColor: colorPanelEmpty,
                          splashColor: color24,
                          tileColor: selectedPanel==index?colorPanelEmpty:Colors.white,

                          trailing: (showPanel==true && selectedPanel==index)?closePanel:openPanel,
                          onTap: () {
                            setState(() {
                              showPanel=!showPanel;
                              if(showPanel==true){
                                selectedPanel = index;
                                userDataPanel = tabView(filteredModerators[index]);
                              }else{
                                selectedPanel = -1;
                                userDataPanel = Container();
                              }
                            });
                          },
                        );
                      }, 
                    ),
                  ),                  
                ],
              ),
            ),
            Container(
              width: (MediaQuery.of(context).size.width-drawerSize)/2,
              color: colorPanelEmpty,
              child: userDataPanel,
            ),
          ],
        ),
      ),
    );
  }

  Widget tabView(Moderators mod){
    return DefaultTabController(
      length: 2, // Número de pestañas
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: color6,
            labelColor: color6,
            tabs: [
              Tab(text: 'Datos Personales'),
              Tab(text: 'Transacciones'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Contenido de la pestaña 1
            Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),width: 80,
                        alignment: Alignment.bottomRight,
                        child: Text('Nombre: ', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appBarcolor4,
                        ),),
                      ),
                      Text(mod.userName, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),width: 80,
                        alignment: Alignment.bottomRight,
                        child: Text('Correo: ', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: appBarcolor4,
                        ),),
                      ),
                      Text(mod.email, style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ],
                  ),
                  
                  Divider(height: 50,),
                  Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.bottomRight,
                    child: FilledButton.tonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 255, 209, 203)),
                      ),
                      child: Text('Eliminar',style: TextStyle(color: Color.fromARGB(255, 221, 47, 35)),),
                      onPressed: ()async{
                        var response = await Services().deleteMod(mod.id, widget.token);
                        fetchModerators();
                      }, 
                    ),
                  ),
                ]
              ),
            ),
            // Contenido de la pestaña 2
            Center(
              child: TransMd(usuario: mod, token: widget.token),
            ),
          ],
        ),
      ),
    );
  }

  Widget buscador(){
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Container(
        margin: EdgeInsets.all(15),
        height: 30,
        child: TextField(
          controller: ctrl_query,
          style: TextStyle(fontSize: 15),
          cursorColor: color1,
          cursorHeight: 23,
          cursorWidth: 1.0,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            prefixIcon: const Icon(Icons.search,size: 20,),
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
              borderRadius: BorderRadius.all(Radius.circular(7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: color1, width: 1.0), // Borde en foco en gris
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
    );
  }

  void addModDialog()async{
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
                width:MediaQuery.of(context).size.width*0.3,
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