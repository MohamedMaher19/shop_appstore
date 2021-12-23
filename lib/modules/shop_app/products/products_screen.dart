import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shop_app/cubit/shop_cubit.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopStates>(
        listener: (context , state){},
        builder:(context , state){

          return ConditionalBuilder(

           condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null ,
            builder:(context) => BuilderWidget(ShopCubit.get(context).homeModel ,ShopCubit.get(context).categoriesModel! , context  ) ,
            fallback:(context) => Center(child: CircularProgressIndicator()));

    } );

  }




 Widget BuilderWidget (HomeModel ? model , CategoriesModel categoriesModel, context) => SingleChildScrollView(
   physics: BouncingScrollPhysics(),
   child: Column (
     crossAxisAlignment: CrossAxisAlignment.start,

     children: [

       CarouselSlider(

           items: model! .data!.banners!.map((e) =>  Image(

             image: NetworkImage('${e.image}'),
             width: double.infinity,
             fit: BoxFit.cover,
           )
           ).toList(),

           options: CarouselOptions(

             height: 250.0,
             viewportFraction: 1.0,
             initialPage: 0,
             enableInfiniteScroll: true,
             reverse: false,
             autoPlay: true,
             autoPlayInterval: Duration(seconds: 4),
             autoPlayAnimationDuration: Duration(seconds: 1),
             autoPlayCurve: Curves.fastOutSlowIn,
             scrollDirection: Axis.horizontal,

           )),
       SizedBox(height: 10,),

       Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,

           children: [
             Text(
                 'Categories',
             style: TextStyle(
               fontSize: 23.0,
               fontWeight: FontWeight.w800,
             ),

             ),
             SizedBox(height: 10,),

             Container(
               height: 100,
               child: ListView.separated(
                 scrollDirection: Axis.horizontal,
                   physics: BouncingScrollPhysics(),
                   itemBuilder: (context , index) => buildCategoryItem(categoriesModel.data!.data![index]) ,
                   separatorBuilder: (context , index) => SizedBox(width: 10.0,),
                   itemCount: categoriesModel.data!.data!.length),
             ),
             SizedBox(height: 20,),

             Text(
               'New Products',
               style: TextStyle(
                 fontSize: 23.0,
                 fontWeight: FontWeight.w800,
               ),

             ),
           ],
         ),
       ),

       SizedBox(height: 10,),

       Container(
         color: Colors.grey[300],
         child: GridView.count(
           shrinkWrap: true,
           physics: NeverScrollableScrollPhysics(),
           crossAxisCount: 2,
           mainAxisSpacing:1.0 ,
           crossAxisSpacing: 1.0,
           childAspectRatio: 1 / 1.75 ,
           children: List.generate(model.data!.products!.length, (index) => buildGridViewProduct(model.data!.products![index],context)

           ),
         ),
       ),

     ],
   ),
 ) ;


        Widget buildCategoryItem(DataModel model) => Stack(
           alignment: AlignmentDirectional.bottomCenter,
           children: [

            Image(
               image: NetworkImage(model.image!),
               height: 100.0,
               width: 100.0,
               fit: BoxFit.cover,
           ),
          Container(
              color: Colors.black.withOpacity(0.8),
              width: 100,
              child: Text(model.name!,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
              color: Colors.white ,

                 ),
            ),
         )
     ],
     );


  Widget buildGridViewProduct (ProductModel model , context ) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [

              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children:[
                  Image(

                image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200.0,
           ),

                  if (model.discount != 0)


                    Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
              ),
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,

                   children: [
                     Text(
                    model.name!,
                    maxLines: 2,
                   overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         fontSize: 14.0,
                         height: 1.3,
                       ),

          ),
                     SizedBox(height: 3,),
                     Row(
                       children:[

                         Text(
            '${model.price!.round()}',
                         style: TextStyle(
                           fontSize: 12.0,
                           color: defaultColor,
                         ),
          ),
                         SizedBox(width: 5.0,),

                         if (model.discount != 0)

                         Text(
                           '${model.old_price!.round()}',
                           style: TextStyle(
                             fontSize: 10.0,
                             color: Colors.grey,
                             decoration: TextDecoration.lineThrough,
                           ),
                         ),
                         Spacer(),
                         IconButton(
                           icon:CircleAvatar(
                           backgroundColor:ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey ,
                           child : Icon(
                             Icons.favorite_border,
                             size: 14.0,
                             color: Colors.white,
                         ),
                          ),
                         onPressed: (){

                             ShopCubit.get(context).changeFavorites(model.id!);

                           print(model.id);
                         },
                         )


                       ],
                     ),
                   ],
                 ),
               ),

        ],
    ),
  );
}
