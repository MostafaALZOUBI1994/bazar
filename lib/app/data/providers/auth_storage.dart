import 'package:get_storage/get_storage.dart';

class AuthStorage{
  final box = GetStorage();

  saveUserToken(String token){
    box.write('token',token );
  }

  loadUserToken(){
    return box.read('token');
  }
  isLogged(){
    return box.read('token')==null ?false:true;
  }
}