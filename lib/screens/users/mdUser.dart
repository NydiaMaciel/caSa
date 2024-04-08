import 'dart:convert';

import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:demo_casa_3/screens/users/admin/desktop/desktopScaffold.dart';
import 'package:demo_casa_3/screens/users/admin/mobile/mobileScaffold.dart';
import 'package:demo_casa_3/screens/users/mod/mobileScaffoldMod.dart';
import 'package:demo_casa_3/screens/users/modUserLayout.dart';
import 'package:demo_casa_3/services/services.dart';
import 'package:demo_casa_3/services/sessions.dart';
import 'package:flutter/material.dart';

class MdUser extends StatefulWidget {
  dynamic response;
  MdUser({super.key,required this.response});

  @override
  State<MdUser> createState() => _MdUserState();
}


class _MdUserState extends State<MdUser> {
  late Moderators user;
  late Sesion dataSesion;
  bool isLoading = true;
  
  @override
  void initState(){
    super.initState();
    fetchUser();
  }

  Future<void> fetchUser()async{
    var js;
    if (widget.response['type']=='administrator'){
      js = await Services().getAdminById(widget.response['id'],widget.response['access_token']);
    }else{
      js = await Services().getModById(widget.response['id'],widget.response['access_token']);
    }
    
    var json = jsonDecode(js);
    setState(() {
      user = Moderators(id: json['id'], userName: json['user_name'], email: json['email']);
      dataSesion = Sesion(token: widget.response['access_token'], type: widget.response['type']);
      isLoading=false;
      print('USER.name:${user.userName}');
      print('USER.id:${user.id}');
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return Center(child: CircularProgressIndicator(),);
    }
    if(widget.response['type']=='administrator'){
      return ModUserLayout(mobileScaffold: mobileScaffold(user: user,dataSesion: dataSesion,), desktopScaffold: DesktopScaffold(usuario: user,dataSesion: dataSesion));
    }
    return mobileScaffoldMod(user: user,dataSesion: dataSesion,);
  }
}