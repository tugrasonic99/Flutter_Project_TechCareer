import 'package:flutter_final/entity/sepet_yemekler.dart';
import 'package:flutter_final/entity/sepet_yemekler_cevap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class SepetYemeklerDao{


  List<SepetYemekler> parseSepetYemeklerCevap(String cevap){
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepetYemekListesi;

  }

  Future<List<SepetYemekler>> sepetTumYemekler(String kullanici_adi) async{
    var url=Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php");
    var veri={"kullanici_adi":kullanici_adi};
    var cevap=await http.post(url,body:veri);
    return parseSepetYemeklerCevap(cevap.body);
  }

  Future <void> sepeteEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async{
    var url=Uri.parse("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php");
    var veri={"yemek_adi": yemek_adi, "yemek_resim_adi":yemek_resim_adi, "yemek_fiyat": yemek_fiyat.toString(),"yemek_siparis_adet":yemek_siparis_adet.toString(),"kullanici_adi":kullanici_adi};
    var cevap=await http.post(url,body:veri);
    print("Sepete Eklendi: ${cevap.body}");

  }

  Future <void> sepettenSil(int sepet_yemek_id,String kullanici_adi) async{
    var url=Uri.parse("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php");
    var veri={"sepet_yemek_id": sepet_yemek_id.toString(), "kullanici_adi": kullanici_adi};
    var cevap=await http.post(url,body:veri);
    print("Sepetten silindi: ${cevap.body}");

  }



}