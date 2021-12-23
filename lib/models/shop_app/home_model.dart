 class HomeModel {

  bool ? status ;
  HomeDataModel? data ;


  HomeModel.fromJson(Map<String , dynamic> json){

    status = json ['status'];

    data =HomeDataModel.fromJson(json ['data']) ;


  }
  }

  class HomeDataModel{

  List<BannerModel> ? banners = [] ;
  List<ProductModel> ? products = [] ;


  HomeDataModel.fromJson(Map<String , dynamic> json)
  {
// الطبيعي ان اعمل الشكل دا عشان اجيب الداتا ولكن دلوقت البيانات ال جواهم عباره عن ليسته ف هستخدم طريقه مختلفه شويه عشان اجيب الداتا
     // banners = json['banners'];
     // products = json['products'];
    // هستعمل ال forEach عشان اخلي عنصر يمر علي كل الدااتا ال جواهم واعمل اضافه للداتا دي في ال لستتين الفاضيين ال انا عاملهم فوق

    json['banners'].forEach((element){
      banners!.add(BannerModel.fromJson(element));

    });

    json['products'].forEach((element){
      products!.add(ProductModel.fromJson(element));

    });

  }
  }

  class BannerModel {
  int ? id ;
  String? image ;

  BannerModel.fromJson(Map<String , dynamic> json)
  {
    id = json ['id'];
    image = json ['image'] ;

  }
  }

 class ProductModel {
   int? id;
   dynamic price;
   dynamic old_price;
   dynamic  discount;
   String? image;
   String? name;
   String? description;
   bool? in_favorites;
   bool? in_cart;

   ProductModel.fromJson(Map<String , dynamic> json)
   {


       id = json['id'];
       price = json['price'];
       old_price = json['old_price'];
       discount = json['discount'];
       image = json['image'];
       name = json['name'];
       description = json['description'];
       in_favorites = json['in_favorites'];
       in_cart = json['in_cart'];

   }

 }




