import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final/cubit/sepet_sayfa_cubit.dart';
import 'package:flutter_final/entity/sepet_yemekler.dart';
import 'package:provider/src/provider.dart';

class SepetSayfa extends StatefulWidget {
  String kullanici_adi;
  SepetSayfa({required this.kullanici_adi});

  @override
  _SepetSayfaState createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  var kullanici_adi="";
  var toplam=0;
  var gosterge=0;

  void initState(){
    super.initState();
    kullanici_adi=widget.kullanici_adi;
    context.read<SepetSayfaCubit>().sepetYemekListesi(kullanici_adi);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.red,
        title: Padding(
          padding: const EdgeInsets.only(right:52.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("YemekSelect", style: TextStyle(fontFamily: "PressStart")),


            ],
          ),
        ),

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height:650 ,
            child: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
              builder: (context, yemekListesi){
                if(yemekListesi.isNotEmpty){
                  return ListView.builder(itemCount: yemekListesi.length,
                      itemBuilder: (context,index){
                        var yemek=yemekListesi[index];
                        gosterge=yemek.yemek_fiyat*yemek.yemek_siparis_adet;
                        toplam=toplam+gosterge;
                        return GestureDetector(
                          onTap:(){
                          } ,
                          child: Card(
                            shadowColor: Colors.grey,
                            elevation: 4,
                            child: SizedBox(height: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width:100,height:80,child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}")),
                                      Text("${yemek.yemek_adi}", style: TextStyle(fontSize: 25,fontFamily: "Bangers"),),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${yemek.yemek_fiyat} ₺ x ${yemek.yemek_siparis_adet}",style: TextStyle(fontSize: 20,fontFamily: "Monchiy",color: Colors.red),),
                                      IconButton(onPressed: (){
                                        _showDialog(context, yemek.sepet_yemek_id, yemek.kullanici_adi);
                                      }, icon: Icon(Icons.delete_outline,color: Colors.black,))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
                else{
                  return Center();
                }
              },

            ),
          ),

          SizedBox(width: 375,child: ElevatedButton(onPressed: (){},child: Text("Öde",style: TextStyle(fontSize:30, fontFamily: "Mochiy")),style: ElevatedButton.styleFrom(primary: Colors.redAccent),))
        ],

      ),

    );
  }
}

void _showDialog(BuildContext context,int sepet_yemek_id,String kullanici_adi) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Uyarı", style: TextStyle(fontFamily: "Mochiy",color: Colors.red)),
        content: new Text("Siparişiniz Kaldırılıyor", style: TextStyle(fontFamily: "Mochiy")),
        actions: <Widget>[
          new TextButton(
              child: new Text("OK"),
              onPressed:(){
                context.read<SepetSayfaCubit>().sil(sepet_yemek_id,kullanici_adi).then((_){
                  context.read<SepetSayfaCubit>().sepetYemekListesi(kullanici_adi);
                }).then((_){Navigator.of(context).pop();});

              }
              ),

          new TextButton(
              child: new Text("CANCEL"),
              onPressed:(){
                Navigator.of(context).pop();
              }

          ),
        ],
      );
    },
  );
}