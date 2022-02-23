import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/style/colors.dart';

import '../../modules/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is ErrorLoginState) {
            showToast(txt:state.error.toString() , state: ToastState.WRONG);
          }
          if(state is SuccessLoginState) {
            CacheHelper.saveData(key: 'token', value: state.model.data!.token).then((value) {
              navigateAndFinish(context, ShopLayout());
            });
          }
        },
          builder: (context,state){
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(),
              body: Align(
                alignment: AlignmentDirectional.center,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Hello,',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 30,
                                  color: Colors.deepPurple),
                            ),
                            Text(
                              'Welcome!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                  color: Colors.deepPurple),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                borderSide: BorderSide(color: defaultColor)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.purple,
                                )),
                            prefixIcon: Icon(
                              Icons.email,
                              color: defaultColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: defaultColor,
                            ),
                          ),
                          controller: emailController,
                          cursorColor: Colors.deepPurple,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email Must Not Be Null';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration:  InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(color: defaultColor)),
                              enabled: true,
                              focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                  )),
                              prefixIcon: const Icon(
                                Icons.vpn_key_rounded,
                                color: defaultColor,
                              ),
                              focusColor: Colors.purple,
                              suffixIcon: IconButton(
                                  onPressed: (){
                                    LoginCubit.get(context).changeVisibility();
                                  },
                                  icon: Icon(
                                    LoginCubit.get(context).suffixIcon,
                                    color: defaultColor,
                                  ),
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                color: defaultColor,
                              )),
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: Colors.deepPurple,
                          textInputAction: TextInputAction.newline,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password Must Not Be Null';
                            }
                            return null;
                          },
                          obscureText: LoginCubit.get(context).password,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: BuildCondition(
                                condition: state is! LoadingLoginState,
                                builder: (context)=>Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.purple,
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: TextButton(
                                    onPressed: () {
                                      if(formKey.currentState!.validate()) {
                                        LoginCubit.get(context).userLogin(
                                            email: emailController.text,
                                            password: passwordController.text
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                fallback: (context)=>const CircularProgressIndicator(color: defaultColor,),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.purple,
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: TextButton(
                                  onPressed: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  child: const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          },
      ),
    );
  }
}
