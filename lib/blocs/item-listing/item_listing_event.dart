import 'package:meta/meta.dart';

@immutable
abstract class ItemListingEvent {}

class OnLoadingItemListing extends ItemListingEvent {}
