import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_app/search/search_screen.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shop_app/cubit/shop_cubit.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = ShopCubit.get(context);


          return Scaffold(
            appBar: AppBar(
              title: Text('Hamza Store'),
              actions: [
                IconButton(icon:Icon(Icons.search) ,
                  onPressed: (){
                  navigationTo(context, SearchScreen());

                  },)
              ],

            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottom(index);

              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem (
            icon: Icon (Icons.home,

            ) ,
            label: 'Home' ,

          ),
                BottomNavigationBarItem (
                icon: Icon (Icons.apps,
             ),
                 label: 'Categories' ,

          ),
                BottomNavigationBarItem (
                icon: Icon (Icons.favorite,
             ),
                 label: 'Favorites' ,

          ),
                BottomNavigationBarItem (
                icon: Icon (Icons.settings,
             ),
                 label: 'Settings' ,

          ),


              ],
            ) ,

          );
        });
  }
}
