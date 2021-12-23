import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/component.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// هعمل موديل فيه الحجات ال هعرضها
// ثم بعد كدا هعكل ليسته فيها عدد معين من الموديل دا بالتفاصيل المختلفه
class BoardingModel{
  final String image ;
  final String title ;
  final String body ;

  BoardingModel({
    required this.title,
    required this.image,
    required this.body
});

}

class OnBoardingScreen extends StatefulWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
   var boardController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(title: 'On Board 1 Title',
        image: 'assets/images/onboarding_0.png',
        body: 'On Board 1 Body'),
    BoardingModel(title: 'On Board 2 Title',
        image: 'assets/images/onboarding_1.png',
        body: 'On Board 2 Body'),
    BoardingModel(title: 'On Board 3 Title',
        image: 'assets/images/onboarding_2.png',
        body: 'On Board 3 Body'),

  ];



  bool isLast = false ;

   void submit (){

     CacheHelper.saveData(key: 'onBoarding', value: true,

     ).then((value) {

       if (value){

         navigateAndFinish(context, ShopLoginScreen());

       }
     }
     );

   }


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(

              onPressed: submit ,


              child: Text(
            'Skip'
          ))
        ],
      ),
      body : Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index){

                  if ( index == boarding.length - 1) {

                    setState(() {  // يعني لو وصل لاخر صوره خلي ال islast ب تروو عشان هستعملها تحت في دوسة الزرار
                      isLast = true ;
                    });
                  }else {
                    setState(() {
                      isLast = false ; // هنا عكس ال فوق
                    });
                  }
                },
                controller: boardController ,
                itemBuilder: (context , index) => buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey ,
                    activeDotColor: defaultColor ,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,

                  ),
                    controller: boardController,
                    count: boarding.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: (){

                    if ( isLast){ // كدا هو ب ترووو

                      submit();


                    }else {
                      boardController.nextPage(
                          duration: Duration(microseconds: 900),
                          curve:Curves.fastLinearToSlowEaseIn );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),

                )
              ],
            )
          ],
        ),
      )


    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage('${model.image}' , )
          ,
          // fit: BoxFit.cover,
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 23.0,
        ),
      ),
      SizedBox(height:15.0 ,),
      Text(
        '${model.body}',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),


    ],
  );
}
