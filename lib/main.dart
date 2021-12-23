import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_app/on_boarding/on_boarding.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'package:shop_app/shop_app/cubit/shop_cubit.dart';

void main()async {


  WidgetsFlutterBinding.ensureInitialized();

  // Bloc.observer  = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();

  Widget widget ;

  bool ?onBoarding = CacheHelper.getData(key: 'onBoarding');

    token =CacheHelper.getData(key: 'token');
   print(token);

  if (onBoarding != null)
    {
      if(token !=null) widget = ShopLayout();
      else widget = ShopLoginScreen();
    }else {
       widget = OnBoardingScreen();
  }

  runApp( MyApp(

    startWidget : widget ,
  ));

}

class MyApp extends StatelessWidget {

  final Widget startWidget;


  MyApp({ required this.startWidget});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),

        child: BlocConsumer<ShopCubit, ShopStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,

                home: AnimatedSplashScreen(
                  splashIconSize: 450,
                  splash: Image.asset('assets/images/market.jpg' , ),
                  nextScreen: startWidget,
                  splashTransition: SplashTransition.fadeTransition,
                  backgroundColor: Colors.white,
                  duration: 7000,



                ),
              );
            },
        ),
    );
  }
}




