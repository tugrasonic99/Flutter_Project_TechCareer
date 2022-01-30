import 'package:flutter_final/entity/yemekler.dart';

class YemeklerCevap{
  List<Yemekler> yemeklerListesi;
  int success;

  YemeklerCevap({required this.yemeklerListesi, required this.success});

  factory YemeklerCevap.fromJson(Map<String,dynamic> json){
    var jsonArray=json["yemekler"] as List;
    List<Yemekler> yemeklerList=jsonArray.map((jsonArrayNesnesi) => Yemekler.fromJson(jsonArrayNesnesi)).toList();
    return YemeklerCevap(yemeklerListesi: yemeklerList, success: json["success"] as int);
  }
}