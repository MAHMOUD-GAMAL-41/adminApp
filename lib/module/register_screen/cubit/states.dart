
abstract class AdminRegisterStates {}

class AdminRegisterInitState extends AdminRegisterStates {}

class AdminRegisterLoadState extends AdminRegisterStates {}

class AdminRegisterErrorState extends AdminRegisterStates {
  final String error;
  AdminRegisterErrorState(this.error);
}
class AdminSendRequestSuccessState extends AdminRegisterStates {
  final String uID;

  AdminSendRequestSuccessState(this.uID);
}

class AdminSendRequestErrorState extends AdminRegisterStates {
  final String error;
  AdminSendRequestErrorState(this.error);
}

class AdminRegisterChangePasswordVisibilityState extends AdminRegisterStates {}
class AdminRegisterChangePasswordState extends AdminRegisterStates {}




class ProfileImagePickedGallerySuccessState extends AdminRegisterStates {}
class ProfileImagePickedGalleryErrorState extends AdminRegisterStates {}

class ProfileImagePickedCameraSuccessState extends AdminRegisterStates {}
class ProfileImagePickedCameraErrorState extends AdminRegisterStates {}

class SocialUploadProfileImageLoadingState extends AdminRegisterStates {}
class SocialUploadProfileImageSuccessState extends AdminRegisterStates {}
class SocialUploadProfileImageErrorState extends AdminRegisterStates {
  final String error;
  SocialUploadProfileImageErrorState(this.error);
}class SocialGetdProfileImageUrlErrorState extends AdminRegisterStates {
  final String error;
  SocialGetdProfileImageUrlErrorState(this.error);
}

class ProfileImageRemoveState extends AdminRegisterStates {}






