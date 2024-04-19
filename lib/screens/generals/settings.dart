import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/generals/colores.dart';
import 'package:demo_casa_3/screens/generals/icons.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/mods.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:demo_casa_3/services/sessions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class Settings extends StatefulWidget {
  Moderators usuario;
  Sesion dataSesion;
  Settings({super.key, required this.usuario, required this.dataSesion});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController ctrl_nweml1 = new TextEditingController();
  TextEditingController ctrl_nweml2 = new TextEditingController();
  TextEditingController ctrl_nwpwd1 = new TextEditingController();
  TextEditingController ctrl_nwpwd2 = new TextEditingController();
  TextEditingController ctrl_nwusr1 = new TextEditingController();
  TextEditingController ctrl_nwusr2 = new TextEditingController();
  TextEditingController password = new TextEditingController();
  bool changesUpdated = false;
  
  @override
  Widget build(BuildContext context) {
    double MQwidth = MediaQuery.of(context).size.width;
    bool responsive_ = MQwidth<1100? true:false;
    return Container(
      color: Colors.white,
        width: MQwidth,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Theme(
                data:Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  iconColor: color6,
                  leading: Icon(iconUsuario),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  tilePadding: EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
                  childrenPadding: EdgeInsets.only(top: 3, bottom: 20, right: 30, left: 30),
                  title: const Text('Cuenta', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),),
                  children: [
                    ListTile(
                      title: const Text('Nombre de Usuario', style: TextStyle(fontWeight: FontWeight.w600,)),
                      subtitle: Text(widget.usuario.userName,style: TextStyle(fontSize: 17),),
                    ),
                    ListTile(
                      title: const Text('Correo electrónico', style: TextStyle(fontWeight: FontWeight.w600,)),
                      subtitle: Text(widget.usuario.email,style: TextStyle(fontSize: 17),),
                    ),
                    const SizedBox(height: 20,),
                    const Divider(),
                    Theme(
                      data:Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor: color6,
                        title: const Text('Cambiar nombre de usuario', style: TextStyle(
                          fontWeight: FontWeight.w600,
                        )),
                        childrenPadding: EdgeInsets.zero,
                        children: [
                          Row(
                            children: [ 
                              Container(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*(responsive_?0.20:0.1),
                                child: Text('Nuevo: ',style: TextStyle(fontSize: 17),)),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width*(responsive_?0.5:0.2),
                                margin: EdgeInsets.all(5),
                                child: TextField(
                                  controller: ctrl_nwusr1,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(fontSize: 5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [ 
                              Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*(responsive_?0.20:0.1),
                                child: Text('Confirmar: ',style: TextStyle(fontSize: 17),)
                              ),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width*(responsive_?0.5:0.2),
                                margin: EdgeInsets.all(5),
                                child: TextField(
                                  controller: ctrl_nwusr2,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(fontSize: 5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: FilledButton(
                              child: Text('Guardar cambios', style: TextStyle(fontSize: 17,),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color6)),
                              onPressed: (){
                                if(ctrl_nwusr1.text=='' && ctrl_nwusr2.text=='' ){
                                }else if (ctrl_nwusr1.text!=ctrl_nwusr2.text){
                                  noCoincidence();
                                }else{
                                  passwordConfirm();
                                }
                              }, 
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Theme(
                data:Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  iconColor: color6,
                  leading: Icon(Icons.shield),
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  tilePadding: EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 20),
                  childrenPadding: EdgeInsets.all(10),
                  title: Text('Seguridad', style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),),
                  children: [
                    Theme(
                      data:Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor: color6,
                        title: const Text('Cambiar contraseña', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        )),
                        children: [
                          Row(
                            children: [ 
                              Container(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*(responsive_?0.20:0.1),
                                child: Text('Nuevo: ', style: TextStyle(fontSize: 17),)),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width*(responsive_?0.5:0.2),
                                margin: EdgeInsets.all(5),
                                child: TextField(
                                  controller: ctrl_nwpwd1,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(fontSize: 5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [ 
                              Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*(responsive_?0.20:0.1),
                                child: Text('Confirmar: ',style: TextStyle(fontSize: 17),)
                              ),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width*(responsive_?0.5:0.2),
                                margin: EdgeInsets.all(5),
                                child: TextField(
                                  controller: ctrl_nwpwd2,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(fontSize: 5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            alignment: Alignment.bottomRight,
                            child: FilledButton(
                              child: Text('Guardar cambios', style: TextStyle(fontSize: 17,)),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color6)),
                              onPressed: (){
                                if(ctrl_nwpwd1.text=='' && ctrl_nwpwd2.text=='' ){
                                }else if (ctrl_nwpwd1.text!=ctrl_nwpwd2.text){
                                  noCoincidence();
                                }else{
                                  passwordConfirm();
                                }
                              }, 
                            ),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data:Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        iconColor: color6,
                        title: const Text('Cambiar correo electrónico', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        )),
                        children: [
                          Row(
                            children: [ 
                              Container(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*(responsive_?0.20:0.1),
                                child: Text('Nuevo: ',style: TextStyle(fontSize: 17),)),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width*(responsive_?0.6:0.3),
                                margin: EdgeInsets.all(5),
                                child: TextField(
                                  controller: ctrl_nweml1,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(fontSize: 5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [ 
                              Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width*(responsive_?0.20:0.1),
                                child: Text('Confirmar: ',style: TextStyle(fontSize: 17),)
                              ),
                              Container(
                                height: 35,
                                width: MediaQuery.of(context).size.width*(responsive_?0.6:0.3),
                                margin: EdgeInsets.all(5),
                                child: TextField(
                                  controller: ctrl_nweml2,
                                  style: TextStyle(fontSize: 16),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(5),
                                    labelStyle: TextStyle(fontSize: 5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(
                            padding: EdgeInsets.only(right: 20),
                            alignment: Alignment.bottomRight,
                            child: FilledButton(
                              child: Text('Guardar cambios', style: TextStyle(fontSize: 17,),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color6)),
                              onPressed: (){
                                if(ctrl_nweml1.text=='' && ctrl_nweml2.text=='' ){
                                }else if (ctrl_nweml1.text!=ctrl_nweml2.text){
                                  noCoincidence();
                                }else{
                                  passwordConfirm();
                                }
                              }, 
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]
                ),
              ),
              Divider(),
            ],
          ),
        ),
      
    );
  }

  void passwordConfirm(){
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar cambios'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Para confirmar los cambios, por favor ingrese su contraseña:'),
              TextField(
                controller: password,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            FilledButton(
              child: Text('Confirmar'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(color6)),
              onPressed: ()async{
                var confirm_pwd;
                if(widget.dataSesion.type==""){
                  confirm_pwd = await Services().confirm_pwd_admin(widget.usuario.userName,ctrl_contra.text);
                }else{
                  confirm_pwd = await Services().confirm_pwd_mod(widget.usuario.userName,ctrl_contra.text);
                }
                if(confirm_pwd==true){
                  fetchUpdate();
                }
                if (changesUpdated) {
                  changesSaved();
                } else {
                  errorConfirm();
                }
                Navigator.pop(context); // Cerrar el AlertDialog
              },
            ),
            FilledButton.tonal(
              onPressed: () {
                ctrl_nwpwd1.text='';
                ctrl_nwpwd2.text='';
                ctrl_nweml1.text='';
                ctrl_nweml2.text='';
                ctrl_nwusr1.text='';
                ctrl_nwusr2.text='';
                Navigator.pop(context); // Cerrar el AlertDialog
              },
              child: Text('Cancelar'),
              style: ButtonStyle(
                iconColor: MaterialStateProperty.all(color6),
              ),
            ),
          ],
        );
      }
    );
  }

  Future fetchUpdate()async{
    var response = await Services().updateMod(widget.usuario.id, widget.dataSesion.token, widget.usuario.userName, widget.usuario.email, password.text);
    if(response.statusCode==200 || response.statusCode==201){
      print('${response.statusCode}. ACTUALIZADO');
      setState(() {
        changesUpdated=true;
      });
    }else{
      changesUpdated=false;
    }
  }
  
  void changesSaved(){
    setState(() {

      ctrl_nweml1.text='';
      ctrl_nweml2.text='';
      password.text='';
    });
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      title: Text('Datos guardados',style: TextStyle(fontSize: 18),),
      description: Text('Los datos fueron guardados satisfactoriamente.',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: highModeShadow,
      showProgressBar: false,
    );
  }
  void noCoincidence(){
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: highModeShadow,
      showProgressBar: false,
      title: Text('¡Atención! ',style: TextStyle(fontSize: 18),),
      description: Text('Los campos no coinciden, vuelva a escribirlos.',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
    );
  }

  void errorConfirm(){
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: const Duration(seconds: 4),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: highModeShadow,
      showProgressBar: false,
      title: Text('Contraseña incorrecta ',style: TextStyle(fontSize: 18),),
      description: Text('La contraseña es incorrecta. Por favor, inténtelo de nuevo.',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
    );
    setState(() {
      password.text = '';
      ctrl_nweml1.text = '';
      ctrl_nweml2.text = '';
      ctrl_nwpwd1.text = '';
      ctrl_nwpwd2.text = '';
      ctrl_nwusr1.text = '';
      ctrl_nwusr2.text = '';
    });
  }

}