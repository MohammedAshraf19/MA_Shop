import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/network/end_points.dart';

import '../../../shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit() : super(LoginInit());
  static LoginCubit get(context)=>BlocProvider.of(context);

  bool password =true;
  IconData suffixIcon = Icons.visibility;
  void changeVisibility(){
    password = !password;
    suffixIcon =password?  Icons.visibility:Icons.visibility_off;
    emit(ChangeVisibilityState());
  }

  late LoginModel loginModel;
  void userLogin({
  required String email,
    required String password,
}){
    emit(LoadingLoginState());
    DioHelperShop.postData(
        url:LOGIN,
        data:{
          'email':email,
          'password':password,
        }
    ).then((value){
      loginModel = LoginModel.formJson(value.data);
      emit(SuccessLoginState(loginModel));
    })
        .catchError((error){
          print(error.toString());
      emit(ErrorLoginState(error));
    });
  }
}