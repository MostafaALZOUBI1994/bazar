import 'package:bazarcom/app/data/models/user_model.dart';
import 'package:bazarcom/app/data/repositories/auth_repositoy.dart';
import 'package:bazarcom/app/modules/screens/home_page.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final _user = User().obs;
  User get user => _user.value;
  set user(User value) => this._user.value = value;
  final AuthRepository authRepository;

  AuthController(this.authRepository);

  signUp(String name, String email, String password,String phoneNumber) async {
    user = await authRepository.register(name, email, password,phoneNumber);
    authRepository.saveUserToken(user.jwt);
  }

  login(String email,String password) async {
    user = await authRepository.login( email, password);
    authRepository.saveUserToken(user.jwt);
    Get.off(HomePage());
  }

  getUserProfile() async {
    String token=authRepository.authStorage.loadUserToken();
    user = await authRepository
        .getUserProfile(token);
    user.jwt=token;

  }
}
