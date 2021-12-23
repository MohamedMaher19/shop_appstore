class CategoriesModel {

bool ? status ;
CategoriesDataModel ? data ; // داتا من النوع الكلاس ال تحت


CategoriesModel.fromJson(Map < String , dynamic> json)

{

  status = json ['status'] ;

  data = CategoriesDataModel.fromJson(json['data']);


}

}


class CategoriesDataModel {

  int? currentpage;

  List<DataModel> ? data = [];



  CategoriesDataModel.fromJson(Map <String, dynamic>json){

    currentpage = json ['current_page'];
    json['data'].forEach((element){

      data!.add(DataModel.fromJson(element));
    });
  }
} // دا خاص بالبيانات ال جوا الداتا



class DataModel { // ودا خاص بالبيانات ال في الداتا ال جوا الداتا نفسها

int ? id ;
String ? name ;
String ? image ;

DataModel.fromJson(Map <String , dynamic>json){

  id = json ['id'];
  name = json ['name'] ;
  image = json ['image'];


}


}



// من تحت لفوق :)