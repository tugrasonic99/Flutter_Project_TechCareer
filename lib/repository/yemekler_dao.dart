import 'package:flutter_final/entity/yemekler.dart';
import 'package:flutter_final/entity/yemekler_cevap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class YemeklerDao{


  List<Yemekler> parseYemeklerCevap(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemeklerListesi;

  }


  Future<List<Yemekler>> tumYemekler() async{
    var url=Uri.parse("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php");
    var cevap=await http.get(url);
    return parseYemeklerCevap(cevap.body);
  }






}