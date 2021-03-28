


import 'package:bloc/bloc.dart';

import 'item_listing_event.dart';
import 'item_listing_state.dart';

class ItemListingBloc extends Bloc<ItemListingEvent, ItemListingState> {
  ItemListingBloc() : super(ItemListingState());


  @override
  Stream<ItemListingState> mapEventToState(event) async* {

  }
}