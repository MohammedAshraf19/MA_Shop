class GetComplaintModel {
  bool? status;
  String? message;
  Data? data;

  GetComplaintModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? phone;
  String? email;
  String? message;
  dynamic id;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    message = json['message'];
    id = json['id'];
  }

}
