import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_cart_model.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/home_model.dart';
import '../../shared/components/components.dart';
import '../../shared/style/colors.dart';
import '../product_details/product_details.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return BuildCondition(
          condition: ShopCubit.get(context).getCartModel !=null,
          builder: (context){
            return ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildFavourite(
                    ShopCubit.get(context).getCartModel!,
                  context,
                    index,
                ),
                separatorBuilder: (context,index)=>Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width: double.infinity,height: 1,color: Colors.grey[300],),
                ),
                itemCount: ShopCubit.get(context).getCartModel!.data!.cartItems!.length,
            );
          },
          fallback:(context)=>const Center(child: CircularProgressIndicator(color: defaultColor,)) ,
        );
      },
    );
  }

  Widget buildFavourite(GetCartModel model,context,index,){
    return InkWell(
      onTap: (){
        navigateTo(
            context,
            ProductDetails(
                name: model.data!.cartItems![index].product!.name!,
                image: model.data!.cartItems![index].product!.image!,
                oldPrice: model.data!.cartItems![index].product!.oldPrice!,
                price: model.data!.cartItems![index].product!.price!,
                description: model.data!.cartItems![index].product!.description!,
                discount: model.data!.cartItems![index].product!.discount!,
                id: model.data!.cartItems![index].product!.id!,
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
                      '${model.data!.cartItems![index].product!.image}'
                  ),
                  width: 180,
                 // fit: BoxFit.cover,
                ),
                if(model.data!.cartItems![index].product!.discount!=0)
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
                    '${model.data!.cartItems![index].product!.name}',
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
                        '${model.data!.cartItems![index].product!.price}',
                        style: const TextStyle(
                          color:  defaultColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if(model.data!.cartItems![index].product!.discount!=0)
                        Text(
                          '${model.data!.cartItems![index].product!.oldPrice}',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[300],
                              decoration: TextDecoration.lineThrough
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavourite(productId: model.data!.cartItems![index].product!.id);
                        },
                        icon:  CircleAvatar(
                          radius: 15,
                          backgroundColor:
                          ShopCubit.get(context).favourite[model.data!.cartItems![index].product!.id]!? Colors.red:Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                        iconSize: 20,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      color: defaultColor,
                      onPressed: (){
                        ShopCubit.get(context).changeCart(productId: model.data!.cartItems![index].product!.id);
                      },
                      child: const Text(
                        'Remove from Cart',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,

                        ),
                      ),
                    ),
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
