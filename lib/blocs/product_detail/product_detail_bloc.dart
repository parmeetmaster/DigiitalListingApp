import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

import 'bloc.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(InitialProductDetailState());

  final ProductRepository productRepository = ProductRepository();

  @override
  Stream<ProductDetailState> mapEventToState(ProductDetailEvent event) async* {
    if (event is OnLoadProduct) {
      yield ProductDetailLoading();

      ///Fetch API
      final ResultApiModel response = await productRepository.loadDetail(
        {"id": event.id},
      );
      final Iterable convertAds = response.data["ads"] ?? [];
      final listads = convertAds.map((item) {
        return Ads.fromJson(item);
      }).toList();

      if (response.success) {
        yield ProductDetailSuccess(
          product: ProductModel.fromJson(response.data),
          author: UserModel.fromJson(response.data['author']),
          adslist: listads
        );
      } else {
        yield ProductDetailFail(code: response.code);
      }
    }
  }
}
