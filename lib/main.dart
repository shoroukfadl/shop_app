
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/bloc_observer.dart';
import 'package:shop_app/shared/components/constans.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import 'modules/ShopApp/Layout/ShopLayout.dart';
import 'modules/ShopApp/Login/ShopLoginScreen.dart';
import 'modules/ShopApp/ShopCubit/shopCubit.dart';
import 'modules/ShopApp/ShopCubit/shopState.dart';
import 'modules/ShopApp/onBoarding/onBoarding.dart';

void main() async {

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
 await CashHelper.init();
 bool ?isDark=CashHelper.getData(key: 'isDark');
 Widget ?widget;
 bool? onBoarding=CashHelper.getData(key: 'onBoarding');
token=CashHelper.getData(key: 'token');
 if(onBoarding!=null)
   {
     if(token !=null)
       widget=ShopLayoutScreen();
     else widget= ShopLoginScreen();
   }else
     {
       widget=OnBoardingScreen();
     }

  runApp(MyApp(
      isDark:isDark,
     startWidget:widget ,
  ));
}

class MyApp extends StatelessWidget{
    bool? isDark;
    Widget  ? startWidget;

  MyApp({this.isDark, this.startWidget});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
      BlocProvider(create: (BuildContext context) => ShopCubit(ShopInitialState())..getHomeData()..getCategoriesData()..getFavouriteData()..getUserData()
        ),
      ],
      child:   MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startWidget
    )
    );

  }

}
