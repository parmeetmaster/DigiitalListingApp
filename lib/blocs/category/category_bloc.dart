import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

import 'bloc.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(InitialCategoryState());

  final CategoryRepository categoryRepository = CategoryRepository();

  @override
  Stream<CategoryState> mapEventToState(event) async* {
    if (event is OnLoadCategory) {
      yield CategoryLoading();

      ///Fetch API
      final ResultApiModel result = await categoryRepository.loadCategory();
      //Response response=await categoryRepository.loadCategoryResponse();
      if (result.success) {
        final Iterable refactorCategory = result?.data ?? [];
        final Iterable convertAds = result?.ads?? [];
        final listCategory = refactorCategory.map((item) {
          return CategoryModel.fromJson(item);
        }).toList();
        final listads = convertAds.map((item) {
          return Ads.fromJson(item);
        }).toList();


        ///Sync UI
        yield CategoryLoadSuccess(category: listCategory,adslist: listads);
      } else {
        yield CategoryLoadFail();
      }
    }
  }
}
