import 'package:flutter_final/entity/sepet_yemekler.dart';

class SepetYemeklerCevap{
  List<SepetYemekler> sepetYemekListesi;
  int success;


  SepetYemeklerCevap({required this.sepetYemekListesi, required this.success});


  factory SepetYemeklerCevap.fromJson(Map<String,dynamic> json){
    var jsonArray=json["sepet_yemekler"] as List;
    List<SepetYemekler> sepetYemekList=jsonArray.map((jsonArrayNesnesi) => SepetYemekler.fromJson(jsonArrayNesnesi)).toList();
    return SepetYemeklerCevap(sepetYemekListesi: sepetYemekList, success: json["success"]);
  }
}