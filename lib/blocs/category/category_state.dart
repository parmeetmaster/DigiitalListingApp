import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CategoryState {}

class InitialCategoryState extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoadSuccess extends CategoryState {
  final List<CategoryModel> category;
  final List<Ads> adslist;

  CategoryLoadSuccess({this.category,this.adslist});
}

class CategoryLoadFail extends CategoryState {}
