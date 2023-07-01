class CheckCodeModel {

  String? success;
  String? message;

  CheckCodeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }
}
