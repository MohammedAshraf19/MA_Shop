import 'package:shop_app/models/change_cart_model.dart';
import 'package:shop_app/models/get_complint_model.dart';

abstract class ShopStates{}
class ShopInit extends ShopStates{}
class ChangeIndex extends ShopStates{}

class SuccessGetHomeData extends ShopStates{}
class LoadingGetHomeData extends ShopStates{}
class ErrorGetHomeData extends ShopStates{
  late final error;
  ErrorGetHomeData(this.error);
}

class SuccessGetCategoryData extends ShopStates{}
class LoadingGetCategoryData extends ShopStates{}
class ErrorGetCategoryData extends ShopStates{
  late final error;
  ErrorGetCategoryData(this.error);
}

class SuccessGetUserData extends ShopStates{}
class LoadingGetUserData extends ShopStates{}
class ErrorGetUserData extends ShopStates{
  late final error;
  ErrorGetUserData(this.error);
}

class SuccessUpdateUserData extends ShopStates{}
class LoadingUpdateUserData extends ShopStates{}
class ErrorUpdateUserData extends ShopStates{
  late final error;
  ErrorUpdateUserData(this.error);
}

class SuccessChangeFavouriteData extends ShopStates{}
class ChangeFavouriteData extends ShopStates{}
//class LoadingChangeFavouriteData extends ShopStates{}
class ErrorChangeFavouriteData extends ShopStates{}

class SuccessGetFavouriteData extends ShopStates{}
class LoadingGetFavouriteData extends ShopStates{}
class ErrorGetFavouriteData extends ShopStates{}

class SuccessGetSearchData extends ShopStates{}
class LoadingGetSearchData extends ShopStates{}
class ErrorGetSearchData extends ShopStates{}

class SuccessGetAboutUsData extends ShopStates{}
class LoadingGetAboutUsData extends ShopStates{}
class ErrorGetAboutUsData extends ShopStates{}

class SuccessChangeCartData extends ShopStates{
  final ChangeCartModel changeCartModel;
  SuccessChangeCartData({required this.changeCartModel});
}
class ChangeCartData extends ShopStates{}
class LoadingChangeCartData extends ShopStates{}
class ErrorChangeCartData extends ShopStates{}

class SuccessGetCartData extends ShopStates{}
class LoadingGetCartData extends ShopStates{}
class ErrorGetCartData extends ShopStates{}

class SuccessGetComplaintData extends ShopStates{
  final GetComplaintModel getComplaintModel;
  SuccessGetComplaintData({required this.getComplaintModel});
}
class LoadingGetComplaintData extends ShopStates{}
class ErrorGetComplaintData extends ShopStates{}

class ProfileImageSuccessState extends ShopStates{}
class ProfileImageErrorState extends ShopStates{}