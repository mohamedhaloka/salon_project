class ResetPasswordModel {
  String? email;

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];

  }
}

