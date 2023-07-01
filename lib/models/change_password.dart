class ChangePasswordModel {
  String ?email;
  String ?code ;
  String? newPassword;
  String? newPasswordConfirmation;


  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    code = json['code'] ;
    newPassword = json['new_password'];
    newPasswordConfirmation = json['new_password_confirmation'];
  }


}