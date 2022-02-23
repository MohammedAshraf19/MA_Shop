import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/style/colors.dart';

class ComplintScreen extends StatelessWidget {
var textController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is SuccessGetComplaintData){
          showToast(txt: state.getComplaintModel.message!, state: ToastState.SUCCESS);
          Navigator.pop(context);
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: defaultColor,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                if(state is LoadingGetComplaintData)
                  LinearProgressIndicator(color: defaultColor,),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'what is your complaint ...',
                        hintStyle: TextStyle(
                            color: Colors.grey
                        ),
                        filled: false,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: MaterialButton(
                    onPressed: (){
                      ShopCubit.get(context).makeComplaint(
                          name: ShopCubit.get(context).userModel!.data!.name!,
                          phone: ShopCubit.get(context).userModel!.data!.phone!,
                          email: ShopCubit.get(context).userModel!.data!.email!,
                          message: textController.text,
                      );
                    },
                    color: defaultColor,
                    minWidth: double.infinity,
                    child: const Text(
                      'Send',
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
        );
      },
    );
  }
}
