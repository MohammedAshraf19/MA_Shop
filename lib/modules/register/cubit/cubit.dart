import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(RegisterInit());

  late LoginModel loginModel ;
  static RegisterCubit get(context)=>BlocProvider.of(context);

  bool password =true;
  IconData suffixIcon = Icons.visibility;
  void changeVisibility(){
    password = !password;
    suffixIcon =password?  Icons.visibility:Icons.visibility_off;
    emit(ChangeVisibilityState());
  }


  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
}){
    emit(LoadingRegisterState());
    DioHelperShop.postData(
        url:REGISTER,
        data:{
          'name':name,
      'email':email,
      'password':password,
      'phone':phone,
    }
    ).then((value){
      loginModel = LoginModel.formJson(value.data);
      emit(SuccessRegisterState(loginModel));
    })
        .catchError((error){
      emit(ErrorRegisterState(error));
    });
  }
}