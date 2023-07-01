
import 'package:salon_app/models/user_data_model.dart';

abstract class HomeLayoutStates {}

class AppInitialStates extends HomeLayoutStates {}

class HomeLoadingStates extends HomeLayoutStates {}
class HomeSuccessStates extends HomeLayoutStates {}
class HomeErrorStates extends HomeLayoutStates {}

class ChangeBottomNavState extends HomeLayoutStates {}

class GetSuccessUserData extends HomeLayoutStates {
  final UserDataModel userData;
  GetSuccessUserData({required this.userData});
}
class GetErrorUserData extends HomeLayoutStates {}

class GetErrorBarberData extends HomeLayoutStates {}

class GetSuccessBarberData extends HomeLayoutStates {}

class GetErrorServicesData extends HomeLayoutStates {}

class GetSuccessServicesData extends HomeLayoutStates {}

class LoadingChooseServiceData extends HomeLayoutStates {}
class GetChooseServiceLoadingData extends HomeLayoutStates {}
class GetChooseServiceSuccessData extends HomeLayoutStates {}
class GetChooseServiceErrorData extends HomeLayoutStates {}
class GetNotifyLoadingData extends HomeLayoutStates {}
class GetNotifySuccessData extends HomeLayoutStates {}
class GetNotifyErrorData extends HomeLayoutStates {}

class SuccessChooseServiceData extends HomeLayoutStates {}
class ErrorChooseServiceData extends HomeLayoutStates {}
class UpdateErrorStatusData extends HomeLayoutStates {}

class UpdateSuccessStatusData extends HomeLayoutStates {}
class GetAppointmentSuccessData extends HomeLayoutStates {}
class GetAppointmentErrorData extends HomeLayoutStates {}
class GetSpecificAppointmentSuccessData extends HomeLayoutStates {}
class GetSpecificAppointmentErrorData extends HomeLayoutStates {}
class AddServices extends HomeLayoutStates {}
