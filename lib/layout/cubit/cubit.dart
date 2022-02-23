import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/about_us_model.dart';
import 'package:shop_app/models/category_model.dart';
import 'package:shop_app/models/change_favourite_model.dart';
import 'package:shop_app/models/get_cart_model.dart';
import 'package:shop_app/models/get_favoutite_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/cart/cart_screen.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favourite/favourite_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/setting/setting_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../models/change_cart_model.dart';
import '../../models/get_complint_model.dart';
import '../../models/user_model.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInit());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changIndex(index) {
    currentIndex = index;
    emit(ChangeIndex());
  }

  List<String> title = [
    'Home',
    'Categories',
    'Favourite',
    'Cart',
    'Profile',
  ];
  List<Widget> screen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    CartScreen(),
    SettingScreen(),
  ];
  HomeModel? homeModel;
  Map<int, bool> favourite = {};
  Map<int, bool> cart = {};
  void getHomeData() {
    emit(LoadingGetHomeData());
    DioHelperShop.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data.products.forEach((element) {
        favourite.addAll({element.id: element.inFavorites});
      });
      homeModel!.data.products.forEach((element) {
        cart.addAll({element.id: element.inCart});
      });
      emit(SuccessGetHomeData());
    }).catchError((error) {
      emit(ErrorGetHomeData(error));
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData() {
    emit(LoadingGetCategoryData());
    DioHelperShop.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);
      emit(SuccessGetCategoryData());
    }).catchError((error) {
      emit(ErrorGetCategoryData(error));
    });
  }

  UserModel? userModel;
  void getUserData() {
    emit(LoadingGetUserData());
    DioHelperShop.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = UserModel.formJson(value.data);
      emit(SuccessGetUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetUserData(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(LoadingUpdateUserData());
    DioHelperShop.putData(data: {
      'name': name,
      'email': email,
      'phone': phone,
    }, url: UPDATE_PROFILE, token: token)
        .then((value) {
      userModel = UserModel.formJson(value.data);
      emit(SuccessUpdateUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateUserData(error.toString()));
    });
  }

  ChangeFavouriteModel? changeFavouriteModel;
  void changeFavourite({required int productId}) {
    favourite[productId] = !favourite[productId]!;
    emit(ChangeFavouriteData());
    DioHelperShop.postData(
      url: FAVOURITE,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      if (!changeFavouriteModel!.status!) {
        favourite[productId] = !favourite[productId]!;
      }
      getFavorites();
      emit(SuccessChangeFavouriteData());
    }).catchError((error) {
      favourite[productId] = !favourite[productId]!;
      emit(ErrorChangeFavouriteData());
    });
  }

  GetFavouriteModel? getFavouriteModel;
  void getFavorites() {
    emit(LoadingGetFavouriteData());

    DioHelperShop.getData(
        url: FAVOURITE,
        token: token,
    ).then((value)
    {
      getFavouriteModel = GetFavouriteModel.fromJson(value.data);
      emit(SuccessGetFavouriteData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetFavouriteData());
    });
  }

  SearchModel? searchModel;
  void searchProduct({required String txt}) {
    emit(LoadingGetSearchData());
    DioHelperShop.postData(
      url: SEARCH,
      data: {
        'text': txt
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessGetSearchData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetSearchData());
    });
  }


  AboutUsModel? aboutUsModel;
  void getAboutUsData()
  {
    emit(LoadingGetAboutUsData());
    DioHelperShop.getData(
      url: ABOUTUS,
    ).then((value)
    {
      aboutUsModel = AboutUsModel.fromJson(value.data);
      emit(SuccessGetAboutUsData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetAboutUsData());
    });
  }

  ChangeCartModel? cartModel;
  void changeCart({required int productId}) {
    emit(LoadingChangeCartData());
    DioHelperShop.postData(
      url: CART,
      data: {
        'product_id': productId},
      token: token,
    ).then((value) {
      cartModel = ChangeCartModel.fromJson(value.data);
      cart[productId] = !cart[productId]!;
      getCarts();
      emit(SuccessChangeCartData(changeCartModel: cartModel!));
    }).catchError((error) {
      cart[productId] = !cart[productId]!;
      emit(ErrorChangeCartData());
    });
  }

  GetCartModel? getCartModel;
  void getCarts() {
    emit(LoadingGetCartData());
    DioHelperShop.getData(
      url: CART,
      token: token,
    ).then((value)
    {
      getCartModel = GetCartModel.fromJson(value.data);
      emit(SuccessGetCartData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetCartData());
    });
  }


  GetComplaintModel? getComplaintModel;
  void makeComplaint({
    required String name,
    required String phone,
    required String email,
    required String message,
}) {
    emit(LoadingGetComplaintData());
    DioHelperShop.postData(
      url: COMPLAINT,
      data: {
        'name':name,
        'phone':phone,
        'email':email,
        'message':message,
      },
    ).then((value) {
      getComplaintModel = GetComplaintModel.fromJson(value.data);
      emit(SuccessGetComplaintData(getComplaintModel: getComplaintModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetComplaintData());
    });
  }

    File? imageFile ;
  var picker = ImagePicker();
  final ImagePicker _picker = ImagePicker();
  Future<void> getProfileImage() async {
      final  pickedFile = await _picker.pickImage(
       source: ImageSource.gallery,
      );
      if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      print(imageFile!.path);
      emit(ProfileImageSuccessState());
    } else
    {
        emit(ProfileImageErrorState());
    }
  }

}
