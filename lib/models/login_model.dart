class LoginModel{
  late bool status;
  late String message;
   UserDataModel? data;

  LoginModel.formJson(Map<String,dynamic> json){
    status =json['status'];
    message =json['message'];
    data =json['data']!=null?UserDataModel.formJson(json['data']):null;
  }

}
class UserDataModel{
   dynamic id ;
   String? name ;
   String? phone ;
   String? image ;
   String? email ;
   dynamic point ;
   dynamic credit ;
   String? token;

  UserDataModel.formJson(Map<String,dynamic> json){
    id =json['id'];
    name =json['name'];
    email =json['email'];
    phone =json['phone'];
    image =json['image'];
    point =json['point'];
    credit =json['credit'];
    token =json['token'];
  }
}