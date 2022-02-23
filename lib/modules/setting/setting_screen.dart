import 'dart:io';
import 'dart:ui';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/complint/complint_screen.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/components/constants.dart';
import '../../shared/style/colors.dart';

class SettingScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        emailController.text = ShopCubit.get(context).userModel!.data!.email!;
        nameController.text = ShopCubit.get(context).userModel!.data!.name!;
        phoneController.text = ShopCubit.get(context).userModel!.data!.phone!;
        return BuildCondition(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            child: Column(
              children: [
                if (state is LoadingUpdateUserData)
                  const LinearProgressIndicator(
                    color: defaultColor,
                  ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        if(ShopCubit.get(context).imageFile ==null)
                          Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            const CircleAvatar(
                              radius: 79,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                              ),
                            ),
                            CircleAvatar(
                              backgroundColor: defaultColor,
                              radius: 22,
                              child: IconButton(
                                onPressed: () {
                                  ShopCubit.get(context).getProfileImage();
                                },
                                iconSize: 24,
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if(ShopCubit.get(context).imageFile !=null)
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                               CircleAvatar(
                                radius: 79,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 75,
                                  child: Container(
                                   // width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(70),
                                    ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      child: Image.file(
                                          File(ShopCubit.get(context).imageFile!.path),
                                      //  width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                  ),
                                 // backgroundImage:Image.file('${File(ShopCubit.get(context).imageFile!.path)}'), //Image.file(File(ShopCubit.get(context).imageFile.path)),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: defaultColor,
                                radius: 22,
                                child: IconButton(
                                  onPressed: () {
                                    ShopCubit.get(context).getProfileImage();
                                  },
                                  iconSize: 24,
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(
                          height: 20,
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
                                Icons.person,
                                color: defaultColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              hintText: 'User Name',
                              hintStyle: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                            controller: nameController,
                            cursorColor: Colors.deepPurple,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'UserName Must Not Be Null';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                            onTap: () {},
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
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(
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
                                Icons.phone,
                                color: defaultColor,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                              hintText: 'Phone',
                              hintStyle: TextStyle(
                                color: defaultColor,
                              ),
                            ),
                            controller: phoneController,
                            cursorColor: Colors.deepPurple,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'Phone Must Not Be Null';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.phone,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                ShopCubit.get(context).updateUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                            color: defaultColor,
                            minWidth: double.infinity,
                            child: const Text(
                              'UPDATE',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: MaterialButton(
                            onPressed: () {
                              navigateTo(context, ComplintScreen());
                            },
                            color: defaultColor,
                            minWidth: double.infinity,
                            child: const Text(
                              'COMPLAINT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 5),
                          child: MaterialButton(
                            onPressed: () {
                              SignOut(context);
                            },
                            color: defaultColor,
                            minWidth: double.infinity,
                            child: const Text(
                              'LOGOUT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          fallback: (context) => const Center(
              child: CircularProgressIndicator(
            color: defaultColor,
          )),
        );
      },
    );
  }
}
