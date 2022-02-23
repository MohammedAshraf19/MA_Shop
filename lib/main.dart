import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/border_screen/border_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/style/themes.dart';

import 'modules/login/login_screen.dart';
import 'modules/product_details/product_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  DioHelperShop.init();
  token= CacheHelper.get(key: 'token');
  print(token);
  Widget? widget;
  if(token!=null) {
    widget = ShopLayout();
  } else {
    widget = BorderScreen();
  }
  runApp( MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  MyApp({required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopCubit()..getHomeData()..getCategoryData()..getUserData()..getFavorites()..getAboutUsData()..getCarts(),
      child: MaterialApp(
        title: 'Shop App',
        theme: lightTheme,
        home: startWidget,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
