import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/shared/style/colors.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return BuildCondition(
          condition: ShopCubit.get(context).categoryModel !=null,
          builder:(context){
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>buildCategory(ShopCubit.get(context).categoryModel!,index),
                      separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1,color: Colors.grey[300],),
                      itemCount: ShopCubit.get(context).categoryModel!.categoryDataModel.data.length
                  ),
                ),
              ],
            );
          } ,
          fallback: (context)=>const Center(child: CircularProgressIndicator(color: defaultColor,)),
        );
      },
    );
  }

  Widget buildCategory(CategoryModel categoryModel,index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children:  [
           Image(
            image: NetworkImage(
              categoryModel.categoryDataModel.data[index].image,
            ),
            height: 150,
            width: 120,
            fit: BoxFit.contain,
          ),
          const SizedBox(
            width: 5,
          ),
           Text(
            categoryModel.categoryDataModel.data[index].name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          IconButton(
            onPressed: (){},
            icon: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: defaultColor,
            ),
          ),
        ],
      ),
    );
  }
}
