import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final/entity/yemekler.dart';
import 'package:flutter_final/repository/yemekler_dao.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>>{
  AnasayfaCubit():super(<Yemekler>[]);

  var repo=YemeklerDao();

  Future<void> yemekListesi() async{
    var liste=await repo.tumYemekler();
    emit(liste);
  }

}