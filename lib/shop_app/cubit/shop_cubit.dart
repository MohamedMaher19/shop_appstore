import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/change_favorites_model.dart';
import 'package:shop_app/models/shop_app/favorites_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
import 'package:shop_app/modules/shop_app/categories/categories_screen.dart';
import 'package:shop_app/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shop_app/modules/shop_app/products/products_screen.dart';
import 'package:shop_app/modules/shop_app/settings/settings_screen.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [

    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),

  ];

  void changeBottom(int index) {
    // if (index == 3 ) getUserData();
    // if (index == 2 ) getFavorites();

    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

////////////////////////////////////////////////////////////////////////////////////

  HomeModel ? homeModel;

  Map<int , bool> favorites = {} ;  // متغير من نوع ماب عشان هملاه بالقيم ال معمول ليها ليها fav وال لا عن طريق ال id و true او false

  void getHomeData() {
    emit(ShopLoadingHomeDataState());


    DioHelper.getData(

      url: HOME ,
      token: token,

    ).then((value) {

      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element) {  //  كدا انا هملي ال ماب بتاع favorites عن طريق استعمال ال foreach والف علي ال products
        favorites.addAll({
          element.id! : element.in_favorites!,

        });

      });

      print(favorites.toString());

      // print(homeModel!.data!.banners![0].image);
      // print(homeModel!.status);

      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

///////////////////////////////////////////////////////////////////////////////


  CategoriesModel ? categoriesModel; // بعمل اوبجكت من الموديل ال انا عملته

  void getCategories()  {

    emit(ShopLoadingHomeDataState());


    DioHelper.getData(

      url: GET_CATEGORIES ,
      token: token,

    ).then((value) {

      categoriesModel = CategoriesModel.fromJson(value.data);



      emit(ShopSuccessCategoriesState());
    }).catchError((error){

      print(error.toString());

      emit(ShopErrorCategoriesState());
    });
  }


  //////////////////////////////////////////////////////////////////////////

  ChangeFavoritesModel ? changeFavoritesModel ;


void changeFavorites (int productId){

  favorites[productId] = !favorites[productId]!;

  emit(ShopChangeFavoritesState());


  DioHelper.postData(
    url: FAVORITES,
    data: {
      'product_id': productId , // من البوست مان
    },
    token: token ,

).then((value)  {

  changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
  print(value.data);

  if (!changeFavoritesModel!.status!){

    favorites[productId] = !favorites[productId]!;

  }else{

    getFavorites();
  }



  emit(ShopSuccessChangeFavoritesState());

}).catchError((error){

    favorites[productId] = !favorites[productId]!;


    emit(ShopErrorChangeFavoritesState());

});

}

///////////////////////////////////////////////////////////////////////////////////


  FavoritesModel ? favoritesModel; // بعمل اوبجكت من الموديل ال انا عملته

  void getFavorites()  {



    emit(ShopLoadingGetFavoritesState());


    DioHelper.getData(

      url: FAVORITES ,
      token: token,

    ).then((value) {

      favoritesModel = FavoritesModel.fromJson(value.data);

      // print(value.data.toString());



      emit(ShopSuccessGetFavoritesState());
    }).catchError((error){

      print(error.toString());

      emit(ShopErrorGetFavoritesState());
    });
  }


////////////////////////////////////////////////////////////////////////////////

ShopLoginModel  ? userModel ;

  void getUserData()  {



    emit(ShopLoadingUserDataState());


    DioHelper.getData(

      url: PROFILE ,
      token: token,

    ).then((value) {

      userModel = ShopLoginModel.fromJson(value.data);

      print(userModel!.data!.name!);



      emit(ShopSuccessUserDataState());
    }).catchError((error){

      print(error.toString());

      emit(ShopErrorUserDataState());
    });
  }

  ////////////////////////////////////////////////////////////////////////////

  void updateUserData({

  required String name ,
  required String email ,
    required String phone ,


})  {



    emit(ShopLoadingUpdateUserState());


    DioHelper.putData(

      url: UPDATE_PROFILE ,
      token: token,
      data: {

        'name' : name ,
        'email' : email ,
        'phone' : phone ,


      },

    ).then((value) {

      userModel = ShopLoginModel.fromJson(value.data);

      print(userModel!.data!.name!);



      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error){

      print(error.toString());

      emit(ShopErrorUpdateUserState());
    });
  }

}

