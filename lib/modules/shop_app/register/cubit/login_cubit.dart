import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/login_model.dart';
// import 'package:meta/meta.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {

  ShopRegisterCubit() : super(ShopRegisterInitialState());


  static ShopRegisterCubit get(context) => BlocProvider.of(context);// خدت اوبجكت منه لسهوله الوصول اليه


  ShopLoginModel? loginModel ;

void userRegister({
  required String name ,
  required String email ,   // عرفت الاتنين دول هنا لاني هستقبلهم من اليورز لما يدخل البيانات بتاعته
  required String password ,
  required String phone ,


}){
  emit(ShopRegisterLoadingState());

  DioHelper.postData(
    url: REGISTER  , // دي الاند بوينت ال انا مسيفها في ملف الريموت
      data: {         // من البوست مان من ال body محتاج ايميل وباسورد
        'name':name ,
        'email':email ,
        'phone':phone ,
        'password':password,

      },

  ).then((value) {
    // print (value.data);
    loginModel = ShopLoginModel.fromJson(value.data);
    // print(loginModel!.data!.token);
    // print(loginModel!.message);
    // print(loginModel!.status);


    emit(ShopRegisterSuccessState(loginModel!)); // هبعت معاها اللوجين موديل عشان هخرج برا واعمل listen

  }).catchError((error){
    // print(error?.toString());

    emit(ShopRegisterErrorState(error.toString()));
  });


}

bool isPassword = true ;
IconData suffix = Icons.visibility_outlined;

void changePasswordVisiblity (){
  isPassword = !isPassword ;

  suffix = isPassword ? Icons.visibility_outlined:  Icons.visibility_off_outlined;

  emit(ShopRegisterChangePasswordVisibilityState());

}

}
