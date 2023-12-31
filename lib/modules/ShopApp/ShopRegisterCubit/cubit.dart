import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/ShopApp/ShopRegisterCubit/state.dart';

import '../../../models/ShopAppModel/loginModel.dart';
import '../../../shared/network/EndPoints.dart';
import '../../../shared/network/remote/dio_helper.dart';


class ShopRegisterCubit extends Cubit<ShopRegisterStates>{
  ShopRegisterCubit(initialState) : super(ShopRegisterInitialState());
  static ShopRegisterCubit get(context)=>BlocProvider.of(context);
  late ShopLoginModel  loginModel;

  void userRegister({
  required String email,
  required String password,
  required String name,
  required String phone
}){
    emit(ShopRegisterLoadingState());
   DioHelper.postData(
     lang: 'en',
       url: Register,
       data: {
         'email':email,
         'password':password,
         'name':name,
         'phone':phone,
       }).then((value) {
     loginModel= ShopLoginModel.formJson(value.data);
        print(loginModel.status);
         emit(ShopRegisterSuccessState(loginModel));
   }).catchError((error){
     print(error.toString());
     emit(ShopRegisterErrorState(error.toString()));
   });
  }

IconData suffix=Icons.visibility_outlined;
 bool isPassword=false;
  void changePasswordVisibility()
  {
   isPassword=!isPassword;
   suffix=isPassword ? Icons.visibility_outlined:Icons.visibility_off;
   emit(ShopRegisterPasswordVisibility());
  }
}