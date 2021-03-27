import 'package:listar_flutter_pro/models/home_data.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<String> banner;
  final List<CategoryModel> category;
  final List<CategoryModel> location;
  final List<ProductModel> recent;
  final List<Ads> ads;

  HomeSuccess({this.banner, this.category, this.location, this.recent,this.ads});
}

class HomeLoadFail extends HomeState {}
