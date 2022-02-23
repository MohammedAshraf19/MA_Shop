import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/get_favoutite_model.dart';
import 'package:shop_app/modules/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import '../../models/home_model.dart';
import '../../shared/style/colors.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return BuildCondition(
          condition: ShopCubit.get(context).getFavouriteModel !=null,
          builder: (context){
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildFavourite(
                    ShopCubit.get(context).getFavouriteModel!.data!.data![index].product!,
                    context,
                  index,
                  ShopCubit.get(context).homeModel!
                ),
                separatorBuilder: (context,index)=>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width: double.infinity,height: 1,color: Colors.grey[300],),
                ),
                itemCount: ShopCubit.get(context).getFavouriteModel!.data!.data!.length
            );
          },
          fallback:(context)=>const Center(child: CircularProgressIndicator(color: defaultColor,)) ,
        );
      },
    );
  }

  Widget buildFavourite(Product model,context,index,HomeModel homeModel){
    return InkWell(
      onTap: (){
        navigateTo(
          context,
          ProductDetails(
              name: model.name!,
              image: model.image!,
              oldPrice: model.oldPrice,
              price: model.price,
              description: model.description!,
              discount: model.discount,
              id: model.id
          )
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(
                    '${model.image}'
                  ),
                  width: 180,
                ),
                if(model.discount!=0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: Colors.red,
                    child: const Text(
                      'Discount',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                        height: 1,
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: const TextStyle(
                          color:  defaultColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if(model.discount!=0)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[300],
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavourite(productId: model.id!);
                        },
                        icon:  CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          ShopCubit.get(context).favourite[model.id]!? Colors.red:Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                        iconSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
