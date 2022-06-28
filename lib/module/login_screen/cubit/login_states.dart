
abstract class AdminLoginStates {}

class AdminLoginInitState extends AdminLoginStates {}

class AdminLoginLoadState extends AdminLoginStates {}

class AdminLoginSuccessState extends AdminLoginStates {
  final String uID;
  AdminLoginSuccessState(this.uID);
}
class MainAdminLoginSuccessState extends AdminLoginStates {
  MainAdminLoginSuccessState();
}

class AdminLoginErrorState extends AdminLoginStates {
  final String error;

  AdminLoginErrorState(this.error);

}

class AdminResetPasswordErrorState extends AdminLoginStates {
  final String error;

  AdminResetPasswordErrorState(this.error);

}
class AdminChangePasswordVisibilityState extends AdminLoginStates {}
class AdminResetPasswordSuccessState extends AdminLoginStates {}
class AdminInternetConnectedState extends AdminLoginStates {}
class AdminInternetNotConnectedState extends AdminLoginStates {}
