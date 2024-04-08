import 'package:demo_casa_3/screens/data/moderators.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String link = 'https://casa-invita.xyz/api/';

class Services{

  //Administrador
  Future login_Adm(String usr, String pwd) async {
    try {
      var response = await http.post(
        Uri.parse('https://casa-invita.xyz/api/administrator/login'),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'username=$usr&password=$pwd',
      );
      print('ADM: [${response.statusCode}] :: [body]:${response.body}');
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return response;
      }else{
        return null;
      }
    } catch (e) {
      print('ERROR: $e !!!');
      return null;
    }
  }
  
  Future getAdminById(int id, String token)async{
    try{
      var url = Uri.parse(link+'administrator/$id');
      var response = await http.get(url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },);
      //print('Resp.BODY: '+response.body);
      if (response.statusCode==200){
        return response.body;
      }else{
        return '';
      }
    }catch(e) {
      print('ERROR: $e !!!');
      return '';
    }
  }

  Future getAllModerators(String token)async{
    try{
      var url = Uri.parse('https://casa-invita.xyz/api/moderators?limit=10&offset=0');
      var response = await http.get(url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      print("ALL_Mods.code: ${response.statusCode}");
      if(response.statusCode==200){
        var jsn = jsonDecode(response.body);
        return jsn;
      }else{
        return '';
      }
    }catch(e) {
      print('ERROR: $e !!!');
      return '';
    }
  }
  
  Future getAllJugadores(String token)async{
    try{
      var url = Uri.parse(link+'rp-users?limit=10&offset=0');
      var response = await http.get(url,
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("ALL_Users.code: ${response.statusCode}");
      if(response.statusCode==200){
        var jsn = jsonDecode(response.body);
        return jsn;
      }else{
        return '';
      }
    }catch (e){
      print('ERROR: $e !!!');
      return '';
    }
  }

  Future getAllTransactions(String token)async{
    try{
      var url = Uri.parse(link+'transactions?limit=10&offset=0');
      var response = await http.get(url,
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("ALL_Trans.code: ${response.statusCode}");
      if(response.statusCode==200){
        var jsn = jsonDecode(response.body);
        return jsn;
      }else{
        return '';
      }
    }catch (e){
      print('ERROR: $e !!!');
      return '';
    }
  }
  
  
  //Moderador
  Future login_Mod(String usr, String pwd) async {
    try {
      var response = await http.post(
        Uri.parse('https://casa-invita.xyz/api/moderators/login'),
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'username=$usr&password=$pwd',
      );
      print('MOD: [${response.statusCode}] :: [body]:${response.body}');
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        return response;
      }else{
        return null;
      }
    } catch (e) {
      print('ERROR: $e !!!');
      return null;
    }
  }
  
  Future createMod(String name, String email, String pswd, String token)async{
    try{
      var url = Uri.parse(link+'moderators');
      var response = await http.post(url,
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
            "user_name": name,
            "email": email,
            "password": pswd
        }),
      );
      
      print('CreateMod.CODE: ${response.statusCode}');
      print('CreateMod.BODY: '+response.body);
      
      return response;
    }catch(e){
      print('ERROR: $e !!!');
      return null;
    }
  }

  Future getModById(int id, String token)async{
    try{
      var url = Uri.parse(link+'moderators/$id');
      var response = await http.get(url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },);
      //print('Resp.BODY: '+response.body);
      if (response.statusCode==200){
        return response.body;
      }else{
        return '';
      }
    }catch(e) {
      print('ERROR: $e !!!');
      return '';
    }
  }
 
  Future deleteMod(int id, String token)async{
    var url = Uri.parse(link+'moderators/$id');
    var response = await http.delete(url,
      headers:<String, String>{
        'accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    print('DeleteMod.CODE: ${response.statusCode}');
    print('DeleteMod.BODY: '+response.body);

    if ( response.statusCode==204){
      return true;
    }else{
      return false;
    }
  }

  Future getTransactionsModById(String token, int id)async{
    try{ //https://casa-invita.xyz/api/moderators/6/transactions?limit=10&offset=0
      var url = Uri.parse(link+'moderators/${id}/transactions?limit=10&offset=0');
      var response = await http.get(url,
        headers: <String, String>{
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print("ALLTransModsbyID.code: ${response.statusCode}");
      if(response.statusCode==200){
        var jsn = jsonDecode(response.body);
        return jsn;
      }else{
        return '';
      }
    }catch (e){
      print('ERROR: $e !!!');
      return '';
    }
  }

  Future updateMod(int id, String token, String name, String email, String pswd) async{
    try{
      var url = Uri.parse(link+'moderators/$id');
      var response = await http.patch(url,
        headers: <String, String>{
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, String>{
            "user_name": name,
            "email": email,
            "password": pswd
        }),
      );
      
      print('updateMod.CODE: ${response.statusCode}');
      print('updateMod.BODY: '+response.body);
      
      return response.statusCode;
    }catch(e){
      print('ERROR: $e !!!');
      return null;
    }
  }

  //others
  Future getGlobalPoints(String token)async{
    try{
      var url = Uri.parse(link+'user-rp?limit=10&offset=0');
      var response = await http.get(url,
        headers: <String, String>{
          'Authorization': 'Bearer $token',
        },
      );
      print("ALL_Users.code: ${response.statusCode}");
      if(response.statusCode==200){
        var jsn = jsonDecode(response.body);
        return jsn;
      }else{
        return '';
      }
    }catch (e){
      print('ERROR: $e !!!');
      return '';
    }
  }


 

}
