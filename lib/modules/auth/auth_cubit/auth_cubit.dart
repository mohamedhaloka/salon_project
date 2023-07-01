import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:salon_app/utils.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../models/auth_model.dart';
import '../../../models/change_password.dart';
import '../../../models/check_code_model.dart';
import '../../../models/login_model.dart';
import '../../../models/reset_password_model.dart';
import '../../../shared/end_points/end_points.dart';
import '../../../shared/remote_data_source/remote_data_source.dart';

class AuthCubit {
  AuthCubit._();
  static AuthCubit instance = AuthCubit._();

  AuthModel? authModel;

  Future<AuthModel?> userRegister({
    required String name,
    required String email,
    String? password,
    String? confirmPassword,
    required String phone,
    required void Function(Response<dynamic>) onSuccess,
    required void Function(dynamic) onError,
  }) async {
    try {
      final response = await DioHelper.postData(
        path: register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': confirmPassword,
          'phone': phone
        },
      );
      if (response.statusCode == 200) {
        onSuccess(response);
        return AuthModel.fromJson(response.data);
      } else {
        showAlertToast(response.data.toString());

        onError(response.data);
      }
    } catch (e) {
      showAlertToast(e.toString());

      onError(e);
    }
    return null;
  }

  ResetPasswordModel? resetPasswordModel;

  Future<void> enterEmail({
    required String email,
    required void Function(Response<dynamic>) onSuccess,
    required void Function(dynamic) onError,
  }) async {
    await DioHelper.postData(
      path: resetPassword,
      data: {
        'email': email,
      },
    ).then((value) {
      log(value.data.toString(), name: 'RESPONSE');
      resetPasswordModel = ResetPasswordModel.fromJson(value.data);
      onSuccess(value);
    }).catchError((error) {
      showAlertToast(error.toString());
      onError(error);
    });
  }

  Future<LoginModel?> userLogin({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      final result = await DioHelper.postData(
        path: login,
        data: {
          "email": email,
          "password": password,
          "fcm_token": fcmToken,
        },
      );
      return LoginModel.fromJson(result.data);
    } catch (e) {
      if (e is DioError) {
        showAlertToast(e.response!.data.toString());
      } else {
        showAlertToast(e.toString());
      }
      showAlertToast(e.toString());
      return null;
    }
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  }

  ChangePasswordModel? changePasswordModel;

  Future<void> changePassword({
    String? email,
    String? code,
    String? newPassword,
    String? newPasswordConfirmation,
    required void Function(Response<dynamic>) onSuccess,
    required void Function(dynamic) onError,
  }) async {
    await DioHelper.postData(
      path: changePass,
      data: {
        'email': email,
        'code': code,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      },
    ).then((value) {
      onSuccess(value);
    }).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
      onError(error);
    });
  }

  CheckCodeModel? checkCodeModel;

  Future<void> checkCode({
    String? email,
    String? code,
    required void Function(Response<dynamic>) onSuccess,
    required void Function(dynamic) onError,
  }) async {
    await DioHelper.postData(
      path: check,
      data: {
        'email': email,
        'code': code,
      },
    ).then((value) {
      onSuccess(value);
    }).catchError((error) {
      if (error is DioError) {
        showAlertToast(error.response!.data.toString());
      } else {
        showAlertToast(error.toString());
      }
      onError(error);
    });
  }

  Future<void> googleSignIn({
    required void Function(Response<dynamic>) onSuccess,
    required void Function(dynamic) onError,
  }) async {
    try {
      final googleSignInAccount = await GoogleSignIn().signIn();
      final googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      final accessToken = googleSignInAuthentication?.accessToken;
      DioHelper.postData(
        path: loginGoogle,
        data: {
          'provider': 'google',
          'access_provider_token': accessToken,
        },
      ).then((value) async {
        onSuccess(value);
      }).catchError((error) {
        onError(error);
      });
    } catch (e) {
      onError(e);
    }
  }

  Future<void> facebookSignIn({
    required void Function(Response<dynamic>) onSuccess,
    required void Function(dynamic) onError,
  }) async {
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      final userData = await FacebookAuth.i.getUserData();
      final accessToken = result.accessToken;
      DioHelper.postData(
        path: loginGoogle,
        data: {
          'provider': 'facebook',
          'access_provider_token': accessToken!.token,
        },
      ).then((value) {
        onSuccess(value);
      }).catchError((error) {
        if (error is DioError) {
          showAlertToast(error.response!.data.toString());
        } else {
          showAlertToast(error.toString());
        }
        onError(error);
      });
    } catch (e) {
      onError(e);
    }
  }

  Future<void> appleSignIn() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.fullName,
        AppleIDAuthorizationScopes.fullName
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        redirectUri:
            Uri.parse('https://api.dreamwod.app/auth/callbacks/apple-sign-in'),
        clientId: 'com.dreamwod.app.login',
      ),
    );

    DioHelper.postData(
      path: loginGoogle,
      data: {
        'provider': 'apple',
        'access_provider_token': appleIdCredential.authorizationCode,
      },
    ).then((value) {}).catchError((error) {});
  }
}
