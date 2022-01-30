import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final/cubit/anasayfa_cubit.dart';
import 'package:flutter_final/entity/yemekler.dart';
import 'package:flutter_final/views/sepet_sayfa.dart';
import 'package:flutter_final/views/yemek_detay.dart';
import 'package:provider/src/provider.dart';



class Anasayfa extends StatefulWidget {
  String kullanici_adi;
  Anasayfa({required this.kullanici_adi});

  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var kullanici_adi="";

  @override
  void initState(){
    super.initState();
    context.read<AnasayfaCubit>().yemekListesi();
    kullanici_adi=widget.kullanici_adi;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("YemekSelect", style: TextStyle(fontFamily: "PressStart")),


          ],
        ),

      ),
      body: Column(
        children:[
          Container(
            height: 75,
            decoration: BoxDecoration(
              color: Colors.redAccent
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("Local Restaurant",style:TextStyle(fontSize: 13,fontFamily: ("Mochiy")),),
                 ),
                      IconButton(onPressed: (){
                        _showDialog(context);
                      },icon: Icon(Icons.info)),


                ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(width: 45, height:45,child: CircleAvatar(
                          backgroundImage: AssetImage('images/tbc2.jpg'),
                        )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(kullanici_adi,style: TextStyle(fontSize: 13,fontFamily: ("Mochiy")),),
                          ),

                        ],

                      ),


                    ]
                ),
              ],

            ),
          ),
          SizedBox(
            height: 600,
            child: BlocBuilder<AnasayfaCubit,List<Yemekler>>(
              builder: (context, yemekListesi){
                if(yemekListesi.isNotEmpty){
                  return ListView.builder(itemCount: yemekListesi.length,
                      itemBuilder: (context,index){
                        var yemek=yemekListesi[index];
                        return GestureDetector(
                          onTap:(){print("${kullanici_adi} 123");
                          Navigator.push(context, MaterialPageRoute(builder: (context) => YemekDetay(yemek: yemek, kullanici_adi: kullanici_adi)));
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
                                      Text("${yemek.yemek_adi}", style: TextStyle(fontSize:25,fontFamily: "Bangers")),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:25),
                                        child: Text("${yemek.yemek_fiyat} ₺", style: TextStyle(fontSize: 30,color: Colors.red,fontFamily: "Bangers")),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(bottom:8.0, right:8.0),
                                          child: Row(
                                            children:[
                                              Text("Ürün detayı",style: TextStyle(fontFamily: "Mochiy",color: Colors.grey)),
                                              Icon(Icons.arrow_forward),
                                            ],

                                          )
                                      ),
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
        ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SepetSayfa(kullanici_adi: kullanici_adi)));
        },
        label: const Text("Sepet"),
        icon: const Icon(Icons.add_shopping_cart),
        backgroundColor: Colors.red,
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Local Restaurant", style: TextStyle(fontFamily: "Mochiy",color: Colors.red)),
        content: new Text("Uygulamamız sizi en yakınınızdaki restorantla eşleştiriyor", style: TextStyle(fontFamily: "Mochiy")),
        actions: <Widget>[
          new TextButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
