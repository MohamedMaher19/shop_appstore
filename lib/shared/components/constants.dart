import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shop_app/cubit/shop_cubit.dart';

void signOut (context){

  CacheHelper.removeData(key: 'token',).then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });

}


String? token ;
