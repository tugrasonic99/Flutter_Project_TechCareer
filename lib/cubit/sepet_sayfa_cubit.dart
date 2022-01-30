import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final/entity/sepet_yemekler.dart';
import 'package:flutter_final/repository/sepet_yemekler_dao.dart';


class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{
  SepetSayfaCubit():super(<SepetYemekler>[]);

  var repo=SepetYemeklerDao();

  Future <void> sepetYemekListesi(String kullanici_adi) async{
    var liste=await repo.sepetTumYemekler(kullanici_adi);
    emit(liste);
  }

  Future <void> sil(int sepet_yemek_id,String kullanici_adi) async{
    await repo.sepettenSil(sepet_yemek_id, kullanici_adi);

  }

}