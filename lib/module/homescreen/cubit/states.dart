abstract class AdminStates {}

class AdminInitialState extends AdminStates {}

class AdminGetAdminLoadingState extends AdminStates {}

class AdminGetAdminSuccessState extends AdminStates {}

class AdminGetAdminErrorState extends AdminStates {
  final String error;

  AdminGetAdminErrorState(this.error);
}
class UserLoggedOutSuccessState extends AdminStates {}
class AdminRegisterInitState extends AdminStates {}

class AdminRegisterLoadState extends AdminStates {}
class AdminRegisterSuccessState extends AdminStates {}

class AdminRegisterErrorState extends AdminStates {
  final String error;
  AdminRegisterErrorState(this.error);
}


//Homescreen state second design

class AdminChangeScreenRouteState extends AdminStates {}
class AdminGetUsersLoadingState extends AdminStates {}
class AdminGetProductsLoadingState extends AdminStates {}

class AdminGetProductsSuccessState extends AdminStates {}

class AdminGetOrdersInProgressLoadingState extends AdminStates {}
class AdminGetOrdersInProgressSuccessState extends AdminStates {}
class AdminGetOrdersApprovedLoadingState extends AdminStates {}
class AdminGetOrdersApprovedSuccessState extends AdminStates {}
class AdminGetStoresSuccessState extends AdminStates {}
class AdminGetRequestsSuccessState extends AdminStates {}


class AdminGetUsersSuccessState extends AdminStates {}

class AdminGetProductsErrorState extends AdminStates {
  final String error;

  AdminGetProductsErrorState(this.error);
}
class AdminAddProductsSuccessState extends AdminStates {}
class AdminAddProductsLoadingState extends AdminStates {}

class AdminEditProducts1SuccessState extends AdminStates {}
class AdminEditProductsSuccessState extends AdminStates {}
class AdminEditProductsLoadingState extends AdminStates {}
class AdminAddProductsErrorState extends AdminStates {
  final String error;

  AdminAddProductsErrorState(this.error);
}class AdminEditProductsErrorState extends AdminStates {
  final String error;

  AdminEditProductsErrorState(this.error);
}
class AdminRemoveProductsSuccessState extends AdminStates {}
class AdminCancelOrderSuccessState extends AdminStates {}
class AdminApproveOrderSuccessState extends AdminStates {}
class AddingProductPhotoSuccessState extends AdminStates {}
class AddingProductWebPhotoSuccessState extends AdminStates {}
class RemoveProductPhotoSuccessState extends AdminStates {}
class RemoveProductWebPhotoSuccessState extends AdminStates {}
class RemoveProductPhotoFBSuccessState extends AdminStates {}
class RemoveProductPhotoFBErrorState extends AdminStates {
  final String error;

  RemoveProductPhotoFBErrorState(this.error);
}
class RemoveProductPhotolocalSuccessState extends AdminStates {}
class ProfileImagePickedCameraErrorState extends AdminStates {}
class AddingSizeToMapState extends AdminStates {}
class AddingColorToMapState extends AdminStates {}
class RemoveColorToMapState extends AdminStates {}
class RemoveSizeState extends AdminStates {}
class SelecetCategoryState extends AdminStates {}

class UploadVirtualPhotostofirebaseLoadingState extends AdminStates {}
class UploadVirtualPhotostofirebaseSuccessState extends AdminStates {}
class UploadVirtualPhotostofirebaseErrorState extends AdminStates {}

class UploadPhotostofirebaseLoadingState extends AdminStates {}
class UploadPhotostofirebaseSuccessState extends AdminStates {}
class UploadPhotostofirebaseErrorState extends AdminStates {}
class AdminVerifyPasswordSuccessState extends AdminStates {}
class AdminChangePasswordLoadingState extends AdminStates {}
class AdminChangePasswordSuccessState extends AdminStates {}
class AdminInternetConnectedState extends AdminStates {}
class AdminInternetNotConnectedState extends AdminStates {}
class AdminChangePasswordVisibilityState extends AdminStates {}
class AdminChangeNameLoadingState extends AdminStates {}
class AdminChangeNameSuccessState extends AdminStates {}

class AdminVerifyPasswordErrorState extends AdminStates {
  final String error;

  AdminVerifyPasswordErrorState(this.error);
}
class AdminChangeNameErrorState extends AdminStates {
  final String error;

  AdminChangeNameErrorState(this.error);
}
class AdminChangePasswordErrorState extends AdminStates {
  final String error;

  AdminChangePasswordErrorState(this.error);
}

class AdminCreateSuccessState extends AdminStates {
  final String uID;

  AdminCreateSuccessState(this.uID);
}

class AdminCreateErrorState extends AdminStates {
  final String error;
  AdminCreateErrorState(this.error);
}

class AdminRefuseRequestSuccessState extends AdminStates {
  AdminRefuseRequestSuccessState();
}

class AdminRefuseRequestErrorState extends AdminStates {
  final String error;
  AdminRefuseRequestErrorState(this.error);
}
class AdminSendEmailSuccessState extends AdminStates {}
class SwitchVirtualImageSuccessState extends AdminStates {}
class AddingVirtualImageToMapSuccessState extends AdminStates {}
class RemovingVirtualImageToMapSuccessState extends AdminStates {}

class AdminSendEmailErrorState extends AdminStates {
  final String error;
  AdminSendEmailErrorState(this.error);
}