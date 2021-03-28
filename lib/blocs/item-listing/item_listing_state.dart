import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';



class ItemListingState {}


class ItemListingLoading extends ItemListingState {}

class ItemListingSuccess extends ItemListingState {
}

class ItemListingFail extends ItemListingState {}
