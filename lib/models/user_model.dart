class UserModel{
  bool? status;
  String? message;
  UserData? data;

  UserModel.formJson(Map<String,dynamic> json){
    status =json['status'];
    message =json['message'];
    data =json['data']!=null?UserData.formJson(json['data']):null;
  }
}

class UserData{

  dynamic id ;
  String? name ;
  String? email ;
  String? phone ;
  String? image ;
  dynamic point ;
  dynamic credit ;
  String? token;

  UserData.formJson(Map<String,dynamic> json){
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