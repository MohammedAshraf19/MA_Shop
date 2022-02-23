import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';

import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  String? value2;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
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
          body: Form(
            key: formKey,
            child: Padding(
              padding:  EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration:  const InputDecoration(
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
                        Icons.search,
                        color: defaultColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        borderSide: BorderSide(color: Colors.deepPurple),
                      ),
                      labelText: 'Search',
                      labelStyle: TextStyle(
                        color: defaultColor,
                      ),
                    ),
                    controller: searchController,
                    cursorColor: Colors.deepPurple,
                    onFieldSubmitted: (value){
                      ShopCubit.get(context).searchProduct(txt: value);
                      value2 = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'enter text to search';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (state is LoadingGetSearchData) LinearProgressIndicator(color: defaultColor,),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (state is SuccessGetSearchData)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildListProduct(
                          ShopCubit.get(context).searchModel!.data!.data![index],
                          context,
                          //isOldPrice: false,
                        ),
                        separatorBuilder: (context, index) => Container(
                          width: double.infinity,height: 1,color: Colors.grey[300],),
                        itemCount:
                        ShopCubit.get(context).searchModel!.data!.data!.length,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
