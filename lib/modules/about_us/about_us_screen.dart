import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';

import '../../shared/style/colors.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
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
            title: const Text(
              'About App',
              style: TextStyle(
                color: defaultColor
              ),
            ),

          ),
          body:  SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                ShopCubit.get(context).aboutUsModel!.data!.about.toString(),
                style: const TextStyle(
                  height: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
