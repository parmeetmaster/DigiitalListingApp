import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/models/home_data.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/models/model_ads.dart';
import 'package:listar_flutter_pro/repository/repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitialHomeState());
  final HomeRepository homeRepository = HomeRepository();

  @override
  Stream<HomeState> mapEventToState(event) async* {
    if (event is OnLoadingHome) {
      yield HomeLoading();

      ///Make event load category
      AppBloc.categoryBloc.add(OnLoadCategory());

      ///Fetch API Home
      final ResultApiModel response = await homeRepository.loadData();
      if (response.success) {
        final banner = response.data['sliders'].cast<String>() ?? [];
        final Iterable convertCategory = response.data['categories'] ?? [];
        final Iterable convertLocation = response.data['locations'] ?? [];
        final Iterable convertRecent = response.data['recent_posts'] ?? [];
        final Iterable convertAds = response.data['ads'] ?? [];

        final pads=convertAds.map((e) {
          return Ads.fromJson(e);
        }).toList();

        final category = convertCategory.map((item) {
          return CategoryModel.fromJson(item);
        }).toList();

        final location = convertLocation.map((item) {
          return CategoryModel.fromJson(item);
        }).toList();

        final recent = convertRecent.map((item) {
          return ProductModel.fromJson(item);
        }).toList();

        yield HomeSuccess(
          ads: pads,
          banner: banner,
          category: category,
          location: location,
          recent: recent,

        );
      } else {
        yield HomeLoadFail();
      }
    }
  }
}
