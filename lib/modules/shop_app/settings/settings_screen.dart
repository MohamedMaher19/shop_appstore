import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shop_app/cubit/shop_cubit.dart';

class SettingsScreen extends StatelessWidget {
   SettingsScreen({Key? key}) : super(key: key);

  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context , state){} ,
      builder : (context , state) {

        var model  = ShopCubit.get(context).userModel!;
       // هخزن الداتا جوا كل كونترولر عشان اعرضها جواه
        nameController.text = model.data!.name! ;
        emailController.text = model.data!.email! ;
        phoneController.text = model.data!.phone! ;


        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) =>  Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key:formkey,
                  child: Column (
                    children: [

                      if(state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                        SizedBox(height: 20,),

                         defaultFormField(
                          border: const OutlineInputBorder(),
                          type: TextInputType.name,
                          label: 'Name',
                          prefix: Icons.person,
                          controller: nameController,
                          validate:(value){

                            if (value.isEmpty)
                            {
                              return 'خانة الاسم مينفعش تبقي فاضيه يابو عمو' ;
                            }
                            return null ;
                          }
                      ),
                      SizedBox(height: 20,),

                      defaultFormField(
                          border: const OutlineInputBorder(),
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          controller: emailController,
                          validate:(value){

                            if (value.isEmpty)
                            {
                              return 'خانة الايميل مينفعش تبقي فاضيه يابو عمو' ;
                            }
                            return null ;
                          }

                      ),
                      SizedBox(height: 20,),

                      defaultFormField(
                          border: const OutlineInputBorder(),
                          type: TextInputType.phone,
                          label: 'Phone Number',
                          prefix: Icons.phone,
                          controller: phoneController,
                          validate:(value){

                            if (value.isEmpty)
                            {
                              return 'خانةالموبايل مينفعش تبقي فاضيه يابو عمو' ;
                            }
                            return null ;
                          }

                      ),
                      SizedBox(height: 40,),

                      elevatedButtonBuilder(
                          text: 'Logout',
                          width: 600.0,

                          onPressed: (){

                              signOut(context);
                          }),
                      SizedBox(height: 30,),

                      elevatedButtonBuilder(
                          text: 'Update',
                          width: 600.0,

                          onPressed: (){

                            if (formkey.currentState!.validate())
                              {

                                ShopCubit.get(context).updateUserData(

                                  name:nameController.text ,
                                  phone:phoneController.text ,
                                  email:emailController.text ,
                                );

                              }


                          })


                    ],

                  ),
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator(),
          ),

        );
      },


    );
  }
}
