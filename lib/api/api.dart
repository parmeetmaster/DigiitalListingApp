import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:listar_flutter_pro/api/http_manager.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'DioClientInstance.dart';

class Api {
  ///URL API
  // static const String AUTH_LOGIN = "login";
  // static const String AUTH_VALIDATE = "/jwt-auth/v1/token/validate";
  // static const String REGISTER = "/listar/v1/auth/register";
  // static const String FORGOT_PASSWORD = "/listar/v1/auth/reset_password";
  // static const String CHANGE_PASSWORD = "/wp/v2/users/me";
  // static const String CHANGE_PROFILE = "/wp/v2/users/me";
  // static const String GET_SETTING = "/listar/v1/setting/init";
  // static const String GET_HOME = "/home";
  // static const String GET_CATEGORY = "/listar/v1/category/list";
  // static const String GET_WISHLIST = "/listar/v1/wishlist/list";
  // static const String SAVE_WISHLIST = "/listar/v1/wishlist/save";
  // static const String DELETE_WISHLIST = "/listar/v1/wishlist/remove";
  // static const String CLEAR_WISHLIST = "/listar/v1/wishlist/reset";
  // static const String GET_LIST_PRODUCT = "/listar/v1/place/list";
  // static const String GET_COMMENT = "/listar/v1/comments";
  // static const String SAVE_COMMENT = "/wp/v2/comments";
  // static const String GET_PRODUCT_DETAIL = "/listar/v1/place/view";
  // static const String GET_AREA = "/listar/v1/location/list";

  static const String AUTH_LOGIN = "/login";
  static const String AUTH_VALIDATE = "/token_validate";
  static const String REGISTER = "/customer_register";
  static const String FORGOT_PASSWORD = "/reset_password";
  static const String CHANGE_PASSWORD = "/change_password";
  static const String CHANGE_PROFILE = "/change_profile";
  static const String GET_SETTING = "/settings";
  static const String GET_HOME = "/home";
  static const String GET_CATEGORY = "/category_list";
  static const String GET_WISHLIST = "/get_wishlist";
  static const String SAVE_WISHLIST = "/save_wishlist";
  static const String DELETE_WISHLIST = "/delete_wishlist";
  static const String CLEAR_WISHLIST = "/clear_wishlist";
  static const String GET_LIST_PRODUCT = "/products_list";
  static const String GET_COMMENT = "/get_comment";
  static const String SAVE_COMMENT = "/save_comment";
  static const String GET_PRODUCT_DETAIL = "/get_product_details";
  static const String GET_AREA = "/location_list";
  static const String CATEGORY = "/category";
  static const String FEATURE = "/features";
  static const String TAGS = "/tags";

  // search

  Future<Response> getSearchResult(
      int category_id, int cities_id, search_text) async {
    Dio dio = ApiService().getclient();

    var params =  {
      "category": "${category_id}",
      "location": "${cities_id}",
      "search": search_text,
    };

    final result = await dio.post("/search_list",data: FormData.fromMap(params));
    return result;
  }

  Future<Response> getCities() async {
    Dio dio = ApiService().getclient();

    final result = await dio.get("/search_city");
    return result;
  }

  // lsiting item
  ///category api
  Future<dynamic> getCategoriesForListing() async {
    final result = await httpManager.get(url: CATEGORY);
    return result;
  }

  ///features api
  Future<dynamic> getFeatureForListing() async {
    final result = await httpManager.get(url: FEATURE);
    return result;
  }

  ///tags api
  Future<dynamic> getTagsListing() async {
    final result = await httpManager.get(url: TAGS);
    return result;
  }

  ///countries api
  Future<dynamic> getCountryListing() async {
    final result = await httpManager.get(url: "/country");
    return result;
  }

  Future<dynamic> getStateListing(params) async {
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(params);
      var response = await dio.post(
          "https://naxosoft.com/projects/itsme4u/api/state",
          data: formData);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> getCitiesListing(params) async {
    var dio = Dio();
    try {
      FormData formData = new FormData.fromMap(params);
      var response = await dio.post(
          "https://naxosoft.com/projects/itsme4u/api/city",
          data: formData);
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  getApiClient(String token) async {
    Dio _dio = new Dio();
    _dio.interceptors.clear();
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      compact: false,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          // Do something before request is sent
          options.headers["Authorization"] = "Bearer " + token;
          return options;
        },
        onResponse: (Response response) {
          // Do something with response data
          return response; // continue
        },
        onError: (DioError error) async {}));
    _dio.options.baseUrl = "https://naxosoft.com/projects/itsme4u/api";
    return _dio;
  }

  getPlaceName(
    List<Marker> markers,
  ) {
    Dio dio = new Dio();
    return dio.post(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${markers.first.position.latitude},${markers.first.position.longitude}&key=${google_place_api_key}");
  }

  ///Login api
  static Future<dynamic> login(params) async {
    final result = await httpManager.post(url: AUTH_LOGIN, data: params);
    print(AUTH_LOGIN);
    return ResultApiModel.fromJson(result);
  }

  ///Validate token valid
  static Future<dynamic> validateToken() async {
    Map<String, dynamic> result = await httpManager.post(url: AUTH_VALIDATE);
    result['success'] = result['code'] == 'jwt_auth_valid_token';
    result['code'] = result['code'];
    return ResultApiModel.fromJson(result);
  }

  ///Forgot password
  static Future<dynamic> forgotPassword(params) async {
    final result = await httpManager.post(url: FORGOT_PASSWORD, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Register account
  static Future<dynamic> register(params) async {
    final result = await httpManager.post(url: REGISTER, data: params);
    Map<String, dynamic> convertResponse = {
      "success": result['code'] == 200,
      "code": result['code'],
      "data": result
    };
    return ResultApiModel.fromJson(convertResponse);
  }

  ///Change Profile
  static Future<dynamic> changeProfile(params) async {
    final result = await httpManager.post(url: CHANGE_PROFILE, data: params);
    Map<String, dynamic> convertResponse = {
      "success": result['code'] == null,
      "code": result['code'],
      "data": result
    };
    return ResultApiModel.fromJson(convertResponse);
  }

  ///change password
  static Future<dynamic> changePassword(params) async {
    final result = await httpManager.post(url: CHANGE_PASSWORD, data: params);
    Map<String, dynamic> convertResponse = {
      "success": result['code'] == null,
      "code": result['code'],
      "data": result
    };
    return ResultApiModel.fromJson(convertResponse);
  }

  ///Get Setting
  static Future<dynamic> getSetting() async {
    final result = await httpManager.get(url: GET_SETTING);
    return ResultApiModel.fromJson(result);
  }

  ///Get Area
  static Future<dynamic> getArea(params) async {
    final result = await httpManager.get(url: GET_AREA, params: params);
    return ResultApiModel.fromJson(result);
  }

  ///Get Category
  static Future<dynamic> getCategory() async {
    final result = await httpManager.get(url: GET_CATEGORY);
    return ResultApiModel.fromJson(result);
  }

  ///Get Home
  static Future<dynamic> getHome() async {
    final result = await httpManager.get(url: GET_HOME);
    print(result);
    return ResultApiModel.fromJson(result);
  }

  ///Get ProductDetail
  static Future<dynamic> getProductDetail(params) async {
    final result = await httpManager.get(
      url: GET_PRODUCT_DETAIL,
      params: params,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Wish List
  static Future<dynamic> getWishList(params) async {
    final result = await httpManager.get(url: GET_WISHLIST, params: params);
    return ResultApiModel.fromJson(result);
  }

  ///Save Wish List
  static Future<dynamic> addWishList(params) async {
    final result = await httpManager.post(url: SAVE_WISHLIST, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Remove Wish List
  static Future<dynamic> removeWishList(params) async {
    final result = await httpManager.post(url: DELETE_WISHLIST, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Clear Wish List
  static Future<dynamic> clearWishList(params) async {
    final result = await httpManager.post(url: CLEAR_WISHLIST, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<dynamic> getProductList(params) async {
    final result = await httpManager.get(url: GET_LIST_PRODUCT, params: params);
    return ResultApiModel.fromJson(result);
  }

  ///Get Review
  static Future<dynamic> getReview(params) async {
    final result = await httpManager.get(url: GET_COMMENT, params: params);
    return ResultApiModel.fromJson(result);
  }

  ///Save Review
  static Future<dynamic> saveReview(params) async {
    final result = await httpManager.post(url: SAVE_COMMENT, data: params);
    Map<String, dynamic> convertResponse = {
      "success": result['code'] == null,
      "code": result['code'],
      "data": result
    };
    return ResultApiModel.fromJson(convertResponse);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
