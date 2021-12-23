// https://student.valuxapps.com/api/
import 'package:dio/dio.dart';

class DioHelper{

  static Dio ? dio ;


  static init(){ // هستعمل ال init جوا داله ال main عشان اول ما التطبيق يشتغل يقوم مشغل ال dio

    dio = Dio(
        BaseOptions(
          baseUrl: 'https://student.valuxapps.com/api/' , // من البوست مان في ال variables
          receiveDataWhenStatusError: true,
          // في ال login من البوست مان تبع ال headers وحطيته هنا لانه ثابت
        )
    );

  }

  static Future<Response> getData ({
    required  String url,
     String? token,
      Map < String,dynamic>? query,
  }) async {
    dio!.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ,
    };
    return await dio!.get // ال get بتحتاج url و queryparameters وانا بعتهم فوق ف فانكشن ال getdata عشان لما هستعملها ف اكتر من مكان هغير الباريميتر دي
      ( url ,
      queryParameters : query,
    );
  }



  static Future<Response> postData ({ //  هنا بجهز الداله ال من خلالها هبعت البياانات الخاصه بال login
    // واستخدمها ف الكيوبت
    required  String url,
    Map < String,dynamic>? query,
    String? token,
    required Map<String , dynamic> data,

  }) async {
    dio!.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ,
    };
    return  dio!.post (  // ال get بتحتاج url و queryparameters وانا بعتهم فوق ف فانكشن ال getdata عشان لما هستعملها ف اكتر من مكان هغير الباريميتر دي
       url ,
      queryParameters : query,
      data : data ,
    );
  }
 // بعد ما خلصت ال dio هروح استعمله في ال cubit
// واستخدمها ف الكيوبت

  static Future<Response> putData ({

    required  String url,
    Map < String,dynamic>? query,
    String? token,
    required Map<String , dynamic> data,

  }) async {
    dio!.options.headers = {
      'lang': 'en',
      'Content-Type': 'application/json',
      'Authorization': token ,
    };
    return  dio!.put(
      url ,
      queryParameters : query,
      data : data ,
    );
  }
}