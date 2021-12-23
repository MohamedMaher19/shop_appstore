class ShopLoginModel{

  bool? status ;
  String? message ;
  UserData?  data ; // لان الداتا عباره عن اوبجكت وجواها بيانات مختلفه ف لازم اعمله من نوع كلاس معين زي ماعملت تحت

  ShopLoginModel.fromJson(Map<String, dynamic> json){ // named constructor

    status = json ['status'] ;
    message = json ['message'] ;
    data = json ['data'] != null ? UserData.fromJson(json['data']) : null ; // استعملت الطريقه دي في ال check لانه عباره عن ماب ولازم اعمله بارسينج ب اني ادخله جوا الموديل بتاعه ال تحت


  }


}

class UserData {

  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;




  UserData.fromJson(Map<String, dynamic> json){ // named constructor

    id = json ['id'] ;
    name = json ['name'] ;
    email = json ['email'] ;
    phone = json ['phone'] ;
    image = json ['image'] ;
    points = json ['points'] ;
    credit = json ['credit'] ;
    token = json ['token'] ;


  }


}

