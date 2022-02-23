import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/modules/product_details/product_details.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return BuildCondition(
          condition: ShopCubit.get(context).homeModel !=null&&ShopCubit.get(context).categoryModel !=null,
          builder: (context)=>buildProduct(homeModel: ShopCubit.get(context).homeModel,context: context),
          fallback: (context)=>const Center(child: CircularProgressIndicator(color: defaultColor,)),
        );
      },
    );
  }
  Widget buildProduct({
  required HomeModel? homeModel,
    context
}){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all( 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            CarouselSlider(
              items: homeModel!.data.banners.map((element)=>Image(
                image: NetworkImage(
                  element.image,
                ),
                width: double.infinity,
                fit: BoxFit.cover,
              )).toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 3),
                  autoPlayCurve: Curves.easeInQuint,
                  scrollDirection: Axis.horizontal,
                  viewportFraction:1
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'Category',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: defaultColor,
                  fontSize: 30
              ),
            ),
            Container(
              height: 120,
              child: ListView.separated(
                  itemBuilder: (context, index) =>buildCategory(ShopCubit.get(context).categoryModel!,index) ,
                  separatorBuilder: (context, index) => const SizedBox(width: 5,),
                  itemCount: ShopCubit.get(context).categoryModel!.categoryDataModel.data.length,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),

              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'New Products',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: defaultColor,
                fontSize: 30
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children:List.generate(homeModel.data.products.length, (index) => InkWell(
                  onTap: (){},
                    child: buildGirdView(homeModel,index,context)
                ),
                ),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1/1.4,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildGirdView(HomeModel homeModel,index,context){
    return InkWell(
      onTap: (){
        navigateTo(
          context,
          ProductDetails(
            name: homeModel.data.products[index].name,
            image: homeModel.data.products[index].image,
            oldPrice: homeModel.data.products[index].oldPrice,
            price: homeModel.data.products[index].price,
            description: homeModel.data.products[index].description,
            discount: homeModel.data.products[index].discount,
            id:  homeModel.data.products[index].id,

          ),
        );
      },
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.end,
          children:  [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(
                      homeModel.data.products[index].image,
                  ),
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                if(homeModel.data.products[index].discount != 0)
                  Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(5),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    homeModel.data.products[index].name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        '${homeModel.data.products[index].price}',
                        style: const TextStyle(
                            color: defaultColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if(homeModel.data.products[index].discount != 0)
                        Text(
                        '${homeModel.data.products[index].oldPrice}',
                        style:  TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough
                        ),

                      ),
                      const Spacer(),
                      IconButton(
                        padding: EdgeInsets.zero,
                          onPressed: (){
                          ShopCubit.get(context).changeFavourite(productId: homeModel.data.products[index].id
                          );
                          },
                          icon:  CircleAvatar(
                            child: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.white,
                            ),
                            backgroundColor:
                            ShopCubit.get(context).favourite[homeModel.data.products[index].id]!?Colors.red:Colors.grey,
                            radius: 15,
                          ),
                        iconSize: 20,
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget buildCategory(CategoryModel categoryModel,index){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children:  [
         Image(
          image: NetworkImage(
              categoryModel.categoryDataModel.data[index].image
          ),
          height: 120,
          width: 100,
          fit: BoxFit.contain,
        ),
        Container(
          color: Colors.black38,
          width:100 ,
          padding: EdgeInsets.all(5),
          child:  Text(
            categoryModel.categoryDataModel.data[index].name,
            style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}