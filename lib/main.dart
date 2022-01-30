import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final/cubit/anasayfa_cubit.dart';
import 'package:flutter_final/cubit/yemek_detay_cubit.dart';
import 'package:flutter_final/views/anasayfa.dart';


import 'cubit/sepet_sayfa_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create:(context)=>AnasayfaCubit()),
        BlocProvider(create:(context)=>YemekDetayCubit()),
        BlocProvider(create:(context)=>SepetSayfaCubit()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Anasayfa(kullanici_adi: "tugra_cakici" ),
      ),
    );

  }
}




