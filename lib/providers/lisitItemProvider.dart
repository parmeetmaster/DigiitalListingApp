import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:listar_flutter_pro/models/lisiting-item/category_model.dart';
import 'package:listar_flutter_pro/models/lisiting-item/feature_model.dart';
import 'package:listar_flutter_pro/models/lisiting-item/tag_model.dart';
import 'package:listar_flutter_pro/models/model_category.dart';
import 'package:listar_flutter_pro/utils/toast.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:dio/dio.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/logger.dart';

class ListItemProvider extends ChangeNotifier {
  CategoryData catagories;
  FeatureModel featureModel;
  CommonListingModel tagsModel;
  List<dynamic> featureSelected = [];
  List<dynamic> tagsSelected = [];
  dynamic currunt_state = appstate.defaultstate;
  List feature_items;
  List tags_items;
  CommonListingModel countries;
  CommonListingModel state;
  CommonListingModel cities;
  DataItems active_country;
  DataItems active_state;
  DataItems active_city;
  GlobalKey<ScaffoldState> skey;
  BuildContext context;
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  //information
  TextEditingController titleController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController pincodeController = new TextEditingController();
  TextEditingController exceptController = new TextEditingController();

  // address section
  TextEditingController categoryController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController websiteController = new TextEditingController();

  // Social Media
  TextEditingController facebookController = new TextEditingController();
  TextEditingController twitterController = new TextEditingController();
  TextEditingController instagramController = new TextEditingController();
  TextEditingController linkedinController = new TextEditingController();
  TextEditingController youtubeController = new TextEditingController();
  TextEditingController pinterestController = new TextEditingController();

  loadData() async {
    dynamic resp = await Api().getCategoriesForListing();
    dynamic feature_resp = await Api().getFeatureForListing();
    dynamic tags_resp = await Api().getTagsListing();
    dynamic country_resp = await Api().getCountryListing();

    print(resp);

    catagories = CategoryData.fromJson(resp);
    featureModel = FeatureModel.fromJson(feature_resp);
    tagsModel = CommonListingModel.fromJson(tags_resp);
    countries = CommonListingModel.fromJson(country_resp);
    //  state=CommonListingModel.fromJson(state_resp);
    //   cities=CommonListingModel.fromJson(cities_resp);

    generateFeatureItems();
    generateTagsItems();
/*    print("title is ${catagories.data[0].name}");
    print("title is ${featureModel.data[0].name}");
    print("title is tagsModel ${tagsModel.data[0].name}");*/
    currunt_state = appstate.laoding_complete;
    notifyListeners();
  }

  reset() {}

  void generateFeatureItems() {
    feature_items = featureModel.data
        .map((feature) => MultiSelectItem<DataFeature>(feature, feature.name))
        .toList();
  }

  void generateTagsItems() {
    tags_items = tagsModel.data
        .map((tag) => MultiSelectItem<DataItems>(tag, tag.name))
        .toList();
  }

  void showSelected() {
    for (DataFeature item in featureSelected) {
      print("selected data is ${item.name}");
    }
  }

  void showCategoriesDialog() {
    SelectDialog.showModal<String>(
      context,
      label: "Select Category",
      selectedValue: "None",
      items: List.generate(
          catagories.data.length, (index) => "${catagories.data[index].name}"),
      onChange: (String selected) {
        int index = catagories.data.indexWhere((data) => data.name == selected);
        categoryController.text = catagories.data[index].name;
      },
    );
  }

  void getStateUsingAPi(DataItems item) async {
    dynamic state_resp = await Api().getStateListing({"country": item.id});
    state = CommonListingModel.fromJson(state_resp);
  }

  void getCitiesUsingAPi(DataItems item) async {
    dynamic cities_Resp = await Api().getCitiesListing({"state": item.id});
    cities = CommonListingModel.fromJson(cities_Resp);
  }

  void showCountiresDialog() {
    SelectDialog.showModal<String>(
      context,
      label: "Select Country",
      selectedValue: "None",
      items: List.generate(
          countries.data.length, (index) => "${countries.data[index].name}"),
      onChange: (String selected) {
        int index = countries.data.indexWhere((data) => data.name == selected);
        countryController.text = countries.data[index].name;
        active_country = countries.data[index];
        getStateUsingAPi(countries.data[index]);
        showSnackBar("Loading...");
      },
    );
  }

  void showSnackBar(String msg) {
    skey.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 5),
    ));
  }

  void showStateDialog() {
    if (state == null) {
      return;
    }

    SelectDialog.showModal<String>(
      context,
      label: "Select State",
      selectedValue: "None",
      items: List.generate(
          state.data.length, (index) => "${state.data[index].name}"),
      onChange: (String selected) {
        int index = state.data.indexWhere((data) => data.name == selected);
        active_state = state.data[index];
        stateController.text = state.data[index].name;
        showSnackBar("Loading...");
        getCitiesUsingAPi(state.data[index]);
      },
    );
  }

  void showCityDialog() {
    if (cities == null) {
      showSnackBar("Please Select Cities");
      return;
    }

    SelectDialog.showModal<String>(
      context,
      label: "Select City",
      selectedValue: "None",
      items: List.generate(
          cities.data.length, (index) => "${cities.data[index].name}"),
      onChange: (String selected) {
        int index = cities.data.indexWhere((data) => data.name == selected);
        active_city = cities.data[index];
        cityController.text = cities.data[index].name;
      },
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> loadPrimaryImage() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#e6634d",
          actionBarTitle: "Select Primary Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#e6634d",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
  }

  Future<void> loadSecondaryImages() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 300,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#e6634d",
          actionBarTitle: "Select Secondary Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#e6634d",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
  }

  void submit() async {
    print("submission done");
    print("token is ${Application.user.token}");

    if (titleController.text.isEmpty) {
      showtoast(skey, "Name Can'nt be empty");
      return;
    }

    if (countryController.text.isEmpty) {
      showtoast(skey, "country Can'nt be empty");
      return;
    }

    if (stateController.text.isEmpty) {
      showtoast(skey, "state Can'nt be empty");
      return;
    }

    if (cityController.text.isEmpty) {
      showtoast(skey, "city Can'nt be empty");
      return;
    }

    if (cityController.text.isEmpty) {
      showtoast(skey, "pincode Can'nt be empty");
      return;
    }
    if (emailController.text.isEmpty) {
      showtoast(skey, "pincode Can'nt be empty");
      return;
    }

    Dio dio = await Api().getApiClient("${Application.user.token}");
    var map = {
      "name": titleController.text,
      "country": countryController.text,
      "state": stateController.text,
      "state": stateController.text,
      "location": cityController.text,
      "address": addressController.text,
      "postalcode": pincodeController.text,
      "phone": phoneController.text,
      "email": emailController.text,
      "website": websiteController.text,
      "date_picker": "20-08-2020", //todo
      "min_price": "1500", //todo
      "max_price": "25000", //todo
      "latitude": "27.2046", //todo
      "longitude": "77.4977", //todo
      "status": "Active", //todo
      "excerpt": exceptController.text,
      "fb": facebookController.text,
      "twitter": twitterController.text,
      "pinterest": pinterestController.text,
      "linkedin": linkedinController.text,
      "instagram": instagramController.text,
      "youtube": youtubeController.text,
      "youtube": youtubeController.text,
    };

    var formdata = FormData.fromMap(map);

    dio.post("/add_listing", data: formdata);
  }
}
