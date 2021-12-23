import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:shop_app/shop_app/cubit/shop_cubit.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigationTo(context, Widget);
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 140.0,
              height: 140.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage('${article['urlToImage']}'),
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13.0),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );

Widget myDivider() {
  return Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  );
}

Widget articleBuilder(list, {isSearch = false}) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 20),
    fallback: (context) => isSearch
        ? Container()
        : Center(
            child: CircularProgressIndicator(),
          ));

Widget defaultFormField(
        {onTap,
        required TextInputType type,
        required String label,
        required IconData prefix,
        required TextEditingController controller,
        IconData? suffix,
        bool isPassword = false,
        bool isClickable = true,
        onChanged,
        validate,
        onFieldSubmitted,
        suffixPreseed,
        InputBorder? border}) =>
    TextFormField(
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onFieldSubmitted,
      validator: validate,
      onChanged: onChanged,
      onTap: onTap,
      enabled: isClickable,
      cursorHeight: 20.0,
      decoration: InputDecoration(
        border: border,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPreseed,
              )
            : null,
        labelText: label,
        prefixIcon: Icon(prefix),
      ),
    );

void navigationTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//https://newsapi.org/v2/everything?q=tesla&apiKey=5c0f8f04b16e46d4a951efce4abc991e

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false, // هنخلي الراوت ب false عشان نلغي ال فات
    );

Widget elevatedButtonBuilder(
        {onPressed, required String text, double? width}) =>
    ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),
        fixedSize: MaterialStateProperty.all<Size?>(Size(width!, 60.0)),
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 23.0),
      ),
    );


/////////////////////////////////////////////////////////


Widget defaultTextBottom({
  required onPressed,
  required String? text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text!.toUpperCase(),
        style: TextStyle(
            color: Colors.teal, fontWeight: FontWeight.bold, fontSize: 15.0),
      ),
    );

////////////////////////////////////////////////////////////////


void ShowToast({
  required String text,
  required ToastStates state ,

})
=>  Fluttertoast.showToast(


    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 11.0
);


enum ToastStates {SUCCESS , ERROR , WARNING  }

Color chooseToastColor (ToastStates state ) {

 late Color color ;

  switch(state)
  {
    case ToastStates.SUCCESS:
      color = Colors.green ;
    break;
    case ToastStates.SUCCESS:
      color =  Colors.red ;
      break;
    case ToastStates.SUCCESS:
      color = Colors.amber ;
      break;
  }
  return color ;

}

////////////////////////////////////////////////////////////////////

void printFullText (String text){
  final pattern =RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));


}
//////////////////////////////////////////////////////////////////////////

Widget buildListProduct ( model , context , {bool isOldPrice = true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120,
    child: Row(
      children: [

        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(

              image: NetworkImage(model.image!),
              width:120,
              height: 120.0,
              fit: BoxFit.cover,
            ),

            if (model.discount  != 0 && isOldPrice  )


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
        SizedBox(width: 20,),
        Expanded(
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
              Spacer(),
              Row(
                children: [

                  Text(
                    model.price!.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(width: 5.0,),

                  if (model.discount!= 0 && isOldPrice)

                    Text(
                      model.oldPrice!.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Spacer(),
                  IconButton(
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.red : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(model.id!);


                    },
                  )


                ],
              ),
            ],
          ),
        ),

      ],
    ),
  ),
);


