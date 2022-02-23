import 'package:shop_app/models/login_model.dart';

abstract class RegisterStates{}
class RegisterInit extends RegisterStates{}

class ChangeVisibilityState extends RegisterStates{}

class LoadingRegisterState extends RegisterStates{}
class SuccessRegisterState extends RegisterStates{
  late LoginModel model;
  SuccessRegisterState(this.model);
}
class ErrorRegisterState extends RegisterStates{
  late final error;
  ErrorRegisterState(this.error);
}