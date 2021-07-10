import 'package:bazarcom/app/data/providers/auth_provider.dart';
import 'package:bazarcom/app/data/providers/auth_storage.dart';
import 'package:meta/meta.dart';

class AuthRepository {
  final AuthApiClient apiClient;
  final AuthStorage authStorage;
  AuthRepository({@required this.authStorage, @required this.apiClient}) : assert(apiClient != null);

  register(String name,String email,String password,String phoneNumber) async {
    return await apiClient.register(name,email,password,phoneNumber);
  }

  login(String email,String password) async {
    return await apiClient.login(email,password);
  }
  getUserProfile(String token) async {
    return await apiClient.getUserProfile(token);
  }

  saveUserToken(String token){
    return authStorage.saveUserToken(token);
  }
  getUserToken(){
    return authStorage.loadUserToken();
  }


}

