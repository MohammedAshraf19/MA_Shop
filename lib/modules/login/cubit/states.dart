import 'package:shop_app/models/login_model.dart';

abstract class LoginStates{}
class LoginInit extends LoginStates{}
class ChangeVisibilityState extends LoginStates{}

class LoadingLoginState extends LoginStates{}
class SuccessLoginState extends LoginStates{
  late final LoginModel model;
  SuccessLoginState(this.model);
}
class ErrorLoginState extends LoginStates{
   late final  error;
   ErrorLoginState(this.error);
}