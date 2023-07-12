import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/ShopAppModel/searchModel.dart';
import '../../../shared/components/constans.dart';
import '../../../shared/network/EndPoints.dart';
import '../../../shared/network/remote/dio_helper.dart';
import 'SearchSates.dart';


class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(initialState) : super(ShopSearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
 late SearchModel searchModel;
  void getSearch(String text){
    emit(ShopSearchLoadingState());
   DioHelper.postData(
       url: search,
       token: token,
       data: {
         'text':text
       }).then((value) {
         searchModel=SearchModel.fromJson(value.data);
         emit(ShopSearchSuccessState(searchModel));
   }).catchError((error){
     print(error);
     emit(ShopSearchErrorState(error));
   });
  }
}