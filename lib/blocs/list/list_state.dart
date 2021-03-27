import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ListState {}

class InitialListState extends ListState {}

class ListProductLoading extends ListState {}

class ListLoadSuccess extends ListState {
  final List<ProductModel> list;
  final PaginationModel pagination;
  final List<Ads> adslist;
  ListLoadSuccess({this.list, this.pagination,this.adslist});
}

class ListLoadFail extends ListState {}
