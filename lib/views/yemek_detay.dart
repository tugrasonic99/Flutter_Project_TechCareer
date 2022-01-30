import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final/cubit/yemek_detay_cubit.dart';
import 'package:flutter_final/entity/yemekler.dart';
import 'package:provider/src/provider.dart';

import 'anasayfa.dart';

class YemekDetay extends StatefulWidget {
  Yemekler yemek;
  String kullanici_adi;
  YemekDetay({required this.yemek, required this.kullanici_adi});

  @override
  _YemekDetayState createState() => _YemekDetayState();
}

class _YemekDetayState extends State<YemekDetay> {
  var yemek_adi="";
  var yemek_resim_adi="";
  var yemek_fiyat=0;
  int adet=1;
  var kullanici_adi="";
  var yemek_tutan_fiyat=0;



  @override
  void initState(){
    super.initState();
    var yemek=widget.yemek;
    yemek_adi=yemek.yemek_adi;
    yemek_resim_adi=yemek.yemek_resim_adi;
    yemek_fiyat=yemek.yemek_fiyat;
    kullanici_adi=widget.kullanici_adi;
    yemek_tutan_fiyat=yemek_fiyat;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width:400,height:350 ,child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek_resim_adi}")),
            Text("${yemek_adi}",style: TextStyle(fontSize: 45,fontFamily: "Bangers"),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Adet",style: TextStyle(fontSize: 45,fontFamily: "Bangers"),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width:50,height:50,child: ElevatedButton(onPressed: (){setState(() {
                      if(adet==1){
                        adet=1;
                        yemek_tutan_fiyat=yemek_fiyat*adet;

                      }
                      else{
                        adet=adet-1;
                        yemek_tutan_fiyat=yemek_fiyat*adet;
                      }
                    });


                    }, child: Text("-", style: TextStyle(fontSize: 40)),style: ElevatedButton.styleFrom(primary: Colors.redAccent),)),
                    Padding(
                      padding: const EdgeInsets.only(left:20,bottom:12),
                      child: SizedBox(width:50,height:50,child: Text("${adet}",style:TextStyle(fontSize: 40,fontFamily: "Mochiy"))),
                    ),
                    SizedBox(width:50,height:50,child: ElevatedButton(onPressed: (){setState(() {
                      adet=adet+1;
                      yemek_tutan_fiyat=yemek_fiyat*adet;

                    });

                    }, child: Text("+", style: TextStyle(fontSize: 40)),style: ElevatedButton.styleFrom(primary: Colors.redAccent),)),
                  ],

                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                Text("Toplam Tutar:",style: TextStyle(fontSize: 45,fontFamily: "Bangers"),),
                Text("${yemek_tutan_fiyat}₺",style: TextStyle(fontSize: 45,fontFamily: "Bangers",color: Colors.red),),
              ],
            ),


            ElevatedButton(onPressed: (){
              context.read<YemekDetayCubit>().yemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat, adet, kullanici_adi);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Anasayfa(kullanici_adi: kullanici_adi)));

            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sepete Ekle",style: TextStyle(fontSize: 35,fontFamily: "Mochiy"),),
                Icon(Icons.add_shopping_cart_outlined,size: 35,),
              ],
            ),style: ElevatedButton.styleFrom(primary: Colors.redAccent),)

          ],
        ),
      )
    );
  }
}
