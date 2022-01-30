import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final/entity/sepet_yemekler.dart';
import 'package:flutter_final/repository/sepet_yemekler_dao.dart';

class YemekDetayCubit extends Cubit<List<SepetYemekler>>{

  YemekDetayCubit():super(<SepetYemekler>[]);

  var repo=SepetYemeklerDao();

  Future <void> yemekEkle(String yemek_adi,String yemek_resim_adi,int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async{
    await repo.sepeteEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }
}