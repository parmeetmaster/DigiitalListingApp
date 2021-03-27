import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductDetailState {}

class InitialProductDetailState extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailSuccess extends ProductDetailState {
  final UserModel author;
  final ProductModel product;
  final List<Ads> adslist;
  ProductDetailSuccess({this.product, this.author,this.adslist});
}

class ProductDetailFail extends ProductDetailState {
  final String code;
  ProductDetailFail({this.code});
}
