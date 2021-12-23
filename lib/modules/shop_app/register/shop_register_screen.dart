import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/shop_app/login/cubit/login_cubit.dart';
import 'package:shop_app/modules/shop_app/register/cubit/login_cubit.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopRegisterScreen extends StatelessWidget {
   ShopRegisterScreen({Key? key}) : super(key: key);

  var formkey = GlobalKey<FormState>(); // محتاجه في ال validation

   var emailController = TextEditingController();
   var passwordController = TextEditingController();
   var nameController = TextEditingController();
   var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterStates> (
        listener: (context , state) {

          if ( state is ShopRegisterSuccessState)
          {
            if(state.loginModel.status!){ // بعمل check لو ال status ب ترو هعمل ايه ولو ب false هعمل اي يعني لو الداتا غلط او الداتا صح

              print(state.loginModel.message);
              print(state.loginModel.data!.token);

              CacheHelper.saveData(
                key: 'token',

                value: state.loginModel.data!.token,

              ).then((value)
              {
                token = state.loginModel.data!.token ;

                navigateAndFinish(context, ShopLayout());
              },
              );


            }else
            {
              print (state.loginModel.message);

              ShowToast(
                state:ToastStates.ERROR ,
                text: state.loginModel.message!,

              );

            }

          }


        },
        builder: (context , state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
             child: SingleChildScrollView(
                child: Padding(
               padding: const EdgeInsets.all(20.0),
                 child: Form(
                key: formkey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'REGISTER',
                      style: Theme.of(context).textTheme .headline5,

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Register Now To Enjoy Our Products',
                      style: Theme
                          .of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 30,

                      ),
                    defaultFormField(
                      border: const OutlineInputBorder(),
                      controller: nameController,
                      type: TextInputType.name,
                      validate: ( value) {
                        if (value.isEmpty) {
                          return 'please enter your name';
                        }
                        return null ;
                      },
                      label: 'User Name',
                      prefix: Icons.person,
                    ),
                SizedBox(height: 15,),

                    defaultFormField(
                      border: const OutlineInputBorder(),
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: ( value) {
                        if (value.isEmpty) {
                          return 'please enter your email address';
                        }
                        return null ;
                      },
                      label: 'Email Address',
                      prefix: Icons.email_outlined,
                    ),
                    SizedBox(height: 15.0,),
                    defaultFormField(
                      border: const OutlineInputBorder(),
                      isPassword:ShopRegisterCubit.get(context).isPassword ,
                      onFieldSubmitted: (value){

                      },

                      controller: passwordController,
                      suffix:ShopRegisterCubit.get(context).suffix ,
                      suffixPreseed: () {
                        ShopRegisterCubit.get(context). changePasswordVisiblity();

                      },
                      type: TextInputType.visiblePassword,
                      validate: ( value) {
                        if (value.isEmpty) {
                          return 'password is too short';
                        }
                        return null ;
                      },
                      label: 'Password',
                      prefix: Icons.lock_outline,
                    ),
                    SizedBox(height: 15.0,),
                    defaultFormField(
                      border: const OutlineInputBorder(),
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: ( value) {
                        if (value.isEmpty) {
                          return 'please enter your phone number';
                        }
                        return null ;
                      },
                      label: 'Phone Number',
                      prefix: Icons.phone,
                    ),

                    SizedBox(height: 30.0,),


                    ConditionalBuilder( // بستعمل دا لما يكون عندي حالتين وبحط الشرط بتاعي في ال condition  ياما هيشغل ال builder ي اما هيشغل ال fallback

                      condition: state is !ShopRegisterLoadingState,


                      builder: (context) =>elevatedButtonBuilder(
                          text: 'Register',
                          onPressed: () {

                            if ( formkey.currentState!.validate())
                            {

                              ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          width: 600.0),

                      fallback: (BuildContext context) => Center (child: CircularProgressIndicator(),),

                    ),

                  ],


                ),
              ),
            ),
          ),
        ));
      }),
    );
  }
}
