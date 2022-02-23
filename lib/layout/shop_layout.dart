import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/about_us/about_us_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/style/colors.dart';

import '../modules/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){

        return Scaffold(
          appBar: AppBar(
            title: Text(
                ShopCubit.get(context).title[ShopCubit.get(context).currentIndex],
              style: const TextStyle(
                color: defaultColor
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left:  8),
                child: IconButton(
                    onPressed: (){
                      navigateTo(context, SearchScreen());
                    },
                  iconSize: 27,
                    icon: const Icon(
                        Icons.search,
                      color: defaultColor,
                    ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right:  8),
                child: IconButton(
                  onPressed: (){
                    navigateTo(context, AboutUsScreen());
                  },
                  iconSize: 27,
                  icon: const Icon(
                    Icons.announcement,
                    color: defaultColor,
                  ),
                ),
              ),
            ],
          ),
          body: ShopCubit.get(context).screen[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: "",
              ),
            ],
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (index){
              ShopCubit.get(context).changIndex(index);
            },
            type: BottomNavigationBarType.fixed,
            elevation: 20,
          ),
        );
      },
    );
  }
}
