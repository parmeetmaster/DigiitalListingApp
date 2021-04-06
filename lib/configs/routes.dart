import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/screens/edit-listing/display_listing.dart';
import 'package:listar_flutter_pro/screens/edit-listing/edit_list_item_screen.dart';
import 'package:listar_flutter_pro/screens/edit-listing/edit_product_detail.dart';
import 'package:listar_flutter_pro/screens/error_screen/no_locationError.dart';
import 'package:listar_flutter_pro/screens/profile/add_list_item.dart';
import 'file:///D:/Practice%20folder/wetransfer-a1ade2/source/lib/screens/location/location_picker.dart';
import 'package:listar_flutter_pro/screens/screen.dart';

class Routes {
  static const String home = "/home";
  static const String wishList = "/wishList";
  static const String account = "/account";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String productDetail = "/productDetail";
  static const String searchHistory = "/searchHistory";
  static const String category = "/category";

  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String changeLanguage = "/changeLanguage";
  static const String contactUs = "/contactUs";
  static const String aboutUs = "/aboutUs";
  static const String gallery = "/gallery";
  static const String photoPreview = "/photoPreview";
  static const String themeSetting = "/themeSetting";
  static const String listProduct = "/listProduct";
  static const String filter = "/filter";
  static const String review = "/review";
  static const String writeReview = "/writeReview";
  static const String location = "/location";
  static const String setting = "/setting";
  static const String fontSetting = "/fontSetting";
  static const String chooseLocation = "/chooseLocation";
  static const String message = "/message";
  static const String notifications = "/notifications";
  static const String addlistitem = "/addlistitem";
  static const String locationscreen = LocationScreen.classname;
  static const String locationerror = LocationError.classname;
  static const String displaylisting = DisplayListing.classname;
  /*Edit list item*/
  static const String editProductDetailScreen = EditProductDetail.classname;
  static const String editListItemScreen = EditListItemScreen.classname;


  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case editListItemScreen:
        return MaterialPageRoute(
          builder: (context) {
            return EditListItemScreen(carrage:settings.arguments);
          },
        );

      case editProductDetailScreen:
        return MaterialPageRoute(
          builder: (context) {
            return EditProductDetail(settings.arguments);
          },
        );



      case displaylisting:
        return MaterialPageRoute(
          builder: (context) {
            return DisplayListing();
          },
        );

      case locationscreen:
        return MaterialPageRoute(
          builder: (context) {
            return LocationScreen();
          },
        );
      case locationerror:
        return MaterialPageRoute(
          builder: (context) {
            return LocationError();
          },
        );



      case signIn:
        return MaterialPageRoute(
          builder: (context) {
            return SignIn(from: settings.arguments);
          },
          fullscreenDialog: true,
        );

      case signUp:
        return MaterialPageRoute(
          builder: (context) {
            return SignUp();
          },
        );

      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) {
            return ForgotPassword();
          },
        );

      case productDetail:
        return MaterialPageRoute(
          builder: (context) {
            return ProductDetail(settings.arguments);
          },
        );

      case searchHistory:
        return MaterialPageRoute(
          builder: (context) {
            return SearchHistory();
          },
          fullscreenDialog: true,
        );

      case category:
        return MaterialPageRoute(
          builder: (context) {
            return Category();
          },
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (context) {
            return EditProfile();
          },
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return ChangePassword();
          },
        );

      case changeLanguage:
        return MaterialPageRoute(
          builder: (context) {
            return LanguageSetting();
          },
        );

      case themeSetting:
        return MaterialPageRoute(
          builder: (context) {
            return ThemeSetting();
          },
        );

      case filter:
        return MaterialPageRoute(
          builder: (context) {
            return Filter(filter: settings.arguments);
          },
          fullscreenDialog: true,
        );

      case review:
        return MaterialPageRoute(
          builder: (context) {
            return Review(product: settings.arguments);
          },
        );

      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return Setting();
          },
        );

      case fontSetting:
        return MaterialPageRoute(
          builder: (context) {
            return FontSetting();
          },
        );

      case writeReview:
        return MaterialPageRoute(
          builder: (context) => WriteReview(
            product: settings.arguments,
          ),
        );

      case location:
        return MaterialPageRoute(
          builder: (context) => Location(
            location: settings.arguments,
          ),
        );

      case listProduct:
        return MaterialPageRoute(
          builder: (context) {
            return ListProduct(category: settings.arguments);
          },
        );

      case gallery:
        return MaterialPageRoute(
          builder: (context) {
            return Gallery(product: settings.arguments);
          },
          fullscreenDialog: true,
        );

      case photoPreview:
        final Map<String, dynamic> params = settings.arguments;
        return MaterialPageRoute(
          builder: (context) => PhotoPreview(
            galleryList: params['galleries'],
            initialIndex: params['index'],
          ),
          fullscreenDialog: true,
        );

      case chooseLocation:
        return MaterialPageRoute(
          builder: (context) {
            return ChooseLocation(location: settings.arguments);
          },
        );

      case addlistitem:
        return MaterialPageRoute(
          builder: (context) {
            return AddListItem();
          },
        );


      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
