import 'package:salon_app/modules/auth/auth__screens/login_screen.dart';
import 'package:salon_app/shared/componants/componants.dart';
import 'package:salon_app/shared/local_data_source/locale_data_source.dart';

signOut(context) {
  AppPreferences.removeData('token').then((value) {
    if (value) {
      navigateAndFinish(context, const LoginScreen());
    }
  });
}

String? token = '';
