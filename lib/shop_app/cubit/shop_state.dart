part of 'shop_cubit.dart';

@immutable
abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}


class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopSuccessChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopErrorChangeFavoritesState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopLoadingGetFavoritesState extends ShopStates {}


class ShopErrorGetFavoritesState extends ShopStates {}


class ShopSuccessUserDataState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}


class ShopErrorUserDataState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {

  final ShopLoginModel loginModel ;

  ShopSuccessUpdateUserState(this.loginModel);

}

class ShopLoadingUpdateUserState extends ShopStates {}


class ShopErrorUpdateUserState extends ShopStates {}
