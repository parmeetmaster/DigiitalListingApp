import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:listar_flutter_pro/models/carrage.dart';
import 'package:listar_flutter_pro/models/edit_listing/listing_item_model.dart';
import 'package:listar_flutter_pro/models/edit_listing/product_item_model.dart';
import 'package:listar_flutter_pro/models/lisiting-item/category_model.dart';
import 'package:listar_flutter_pro/models/lisiting-item/feature_model.dart';
import 'package:listar_flutter_pro/models/lisiting-item/tag_model.dart';
import 'package:listar_flutter_pro/models/model_category.dart';
import 'package:listar_flutter_pro/utils/toast.dart';
import 'package:listar_flutter_pro/utils/validation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:select_dialog/select_dialog.dart';
import 'package:dio/dio.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/logger.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:listar_flutter_pro/models/edit_listing/product_item_model.dart';

import 'location_provider.dart';

class EditListItemFormProvider extends ChangeNotifier {
  CategoryData catagories;
  CategoryDataItem choosen_category;
  FeatureModel featureModel;
  CommonListingModel tagsModel;
  double container_padding_feature;
  double container_padding_tag;

  List<dynamic> featureSelected = [];
  List<dynamic> tagsSelected = [];
  String selectedFeatureText="";
  String selectedTagsText="";
  List feature_items;
  List tags_items;


  dynamic currunt_state = appstate.defaultstate;

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
  List<Asset> secondary_imges = List<Asset>();
  List<Asset> primaryImages = List<Asset>();
  final picker = ImagePicker();
  File profileImage;
  Carrage carrage;
  final GlobalKey<FormFieldState> feature_key=new GlobalKey<FormFieldState>();

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



  reset() {
     container_padding_feature=10;
     container_padding_tag=10;
   featureSelected = [];
  tagsSelected = [];
      selectedFeatureText="";
      selectedTagsText="";
      feature_items=null;
      tags_items=null;



    catagories = null;
    choosen_category = null;
    featureModel = null;
    tagsModel = null;
    featureSelected = [];
    tagsSelected = [];
    currunt_state = appstate.defaultstate;
    feature_items = null;
    tags_items = null;
    countries = null;
    state = null;
    cities = null;
    active_country = null;
    active_state = null;
    active_city = null;
    skey;
    images = List<Asset>();
    _error = 'No Error Dectected';
    secondary_imges = List<Asset>();
    primaryImages = List<Asset>();

    profileImage = null;

    //information
    titleController = new TextEditingController();
    emailController = new TextEditingController();
    phoneController = new TextEditingController();
    addressController = new TextEditingController();
    pincodeController = new TextEditingController();
    exceptController = new TextEditingController();

    // address section
    categoryController = new TextEditingController();
    countryController = new TextEditingController();
    stateController = new TextEditingController();
    cityController = new TextEditingController();
    websiteController = new TextEditingController();

    // Social Media
    facebookController = new TextEditingController();
    twitterController = new TextEditingController();
    instagramController = new TextEditingController();
    linkedinController = new TextEditingController();
    youtubeController = new TextEditingController();
    pinterestController = new TextEditingController();
  }

  loadData() async {
    dynamic resp;
    dynamic feature_resp;
    dynamic tags_resp;
    dynamic country_resp;

    await Future.wait([
      Api().getCategoriesForListing(),
      Api().getFeatureForListing(),
      Api().getTagsListing(),
      Api().getCountryListing()
    ]).then((List responses) {
      resp = responses[0];
      feature_resp = responses[1];
      tags_resp = responses[2];
      country_resp = responses[3];
    }).catchError((e) {});

    //   print(resp);

    catagories = CategoryData.fromJson(resp);
    featureModel = FeatureModel.fromJson(feature_resp);
    tagsModel = CommonListingModel.fromJson(tags_resp);
    countries = CommonListingModel.fromJson(country_resp);
    generateFeatureItems();
    generateTagsItems();

    notifyListeners();
  }

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
        choosen_category = catagories.data[index];
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

  Future<void> loadPrimaryImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Future<void> loadSecondaryImages() async {
    String error = 'No Error Dectected';

    try {
      secondary_imges = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#e6634d",
          actionBarTitle: "Gallery Images",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#e6634d",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }
  }

  Future<File> getImageFileFromAssets(Asset asset) async {
    final byteData = await asset.getByteData();
    final tempFile =
        File("${(await getTemporaryDirectory()).path}/${asset.name}");
    final file = await tempFile.writeAsBytes(
      byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
    );
    return file;
  }

  getDate() {
    DateTime date = new DateTime.now();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd-MM-yyyy'); //"20-08-2020"
    final String formatted = formatter.format(now);
    return formatted;
  }

// set data is here

  GetProductDetail productDetail;
  void setData(Carrage carrage) async {
    this.carrage = carrage;
    DataListModel dataListModel = this.carrage.dataListModel;
    Dio dio = await Api().getApiClient(Application.user.token);
    Response resp = await dio
        .get("/get_product_details", queryParameters: {"id": dataListModel.id});

     productDetail = GetProductDetail.fromJson(resp.data);

    titleController.text = productDetail.data.postTitle;

    emailController.text = productDetail.data.email;
    phoneController.text = productDetail.data.phone;
    addressController.text = productDetail.data.address;
    pincodeController.text = productDetail.data.zipCode; // todo api response is check and add
    exceptController.text = productDetail.data.postExcerpt;
    active_country=DataItems(id:int.parse(productDetail.data.country),name:productDetail.data.country);
    active_state=DataItems(id:int.parse(productDetail.data.state),name:productDetail.data.stateName);
    active_city=DataItems(id:int.parse(productDetail.data.city),name:productDetail.data.cityName);

    await getStateUsingAPi(DataItems(
        id: active_country.id,
        name:active_country.name));
    await getCitiesUsingAPi(DataItems(
        id: active_state.id,
        name: active_state.name));

    // add features in data
   // DataItems
    setFeature();
setTags();



    // address section
    categoryController.text = productDetail.data.category.name;
     choosen_category= CategoryDataItem(id: dataListModel.category.termId);


    countryController.text = productDetail.data.countryName;
    stateController.text = productDetail.data.stateName;
    cityController.text = productDetail.data.cityName;
    websiteController.text = productDetail.data.website;

    // Social Media
    facebookController.text = productDetail.data.socialNetwork.facebook ?? "";
    twitterController.text = productDetail.data.socialNetwork.twitter ?? "";
    instagramController.text = productDetail.data.socialNetwork.instagram ?? "";
    linkedinController.text = productDetail.data.socialNetwork.linkedin ?? "";
    youtubeController.text = productDetail.data.socialNetwork.youtube ?? "";
    pinterestController.text = productDetail.data.socialNetwork.pinterest ?? "";

    currunt_state = appstate.laoding_complete;
    notifyListeners();
  }

  // submission here
  void submit() async {
    DataListModel dataListModel = carrage.dataListModel;

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
      showtoast(skey, "Email Can'nt be empty");
      return;
    }
    List<int> feature_list = [];
    if (featureSelected.length > 0) {
      for (dynamic item in featureSelected) {
        DataFeature d = item as DataFeature;
        feature_list.add(d.id);
      }

      List<int> tags_list = [];
      if (tagsSelected.length > 0) {
        for (dynamic item in tagsSelected) {
          DataItems d = item as DataItems;
          tags_list.add(d.id);
        }
      }

      // location data
      final locationProvider =
          Provider.of<LocationProvider>(context, listen: false);
      if (locationProvider.markers == null ||
          locationProvider.markers.isEmpty) {
        locationProvider.addMarkerWithoutRefresh(LatLng(
            double.parse(dataListModel.latitude),
            double.parse(dataListModel.longitude)));
        showtoast(skey, "We are using previous location");
      }

      if (Validation().isEmailValid(emailController.text) == false) {
        showtoast(skey, "Email format incorrect");
        return;
      }

      if (Validation().isPhoneNumberValid(phoneController.text) == false) {
        showtoast(skey, "Phone Number format incorrect");
        return;
      }

      if (Validation().isNumber(pincodeController.text) == false) {
        showtoast(skey, "Pincode must be Numerical");
        return;
      }

      // primary images
      if (profileImage==null || profileImage.path.split('/').last == null) {
        showtoast(skey, "No Primary Image selected");
        return;
      }

      String fileName = profileImage.path.split('/').last;

      MultipartFile primary_image =
          await MultipartFile.fromFile(profileImage.path, filename: fileName);

      /* secondary images*/

      List<Asset> images = secondary_imges;
      List<MultipartFile> multipartImageList = new List<MultipartFile>();
      if (null != images) {
        for (Asset asset in images) {
          File f = await getImageFileFromAssets(asset);
          MultipartFile sec_img =
              await MultipartFile.fromFile(f.path, filename: fileName);
          multipartImageList.add(sec_img);
        }
      }

      await AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.INFO,
        customHeader: Padding(
            padding: EdgeInsets.all(25),
            child: SvgPicture.asset("assets/images/hourglass.svg")),
        title: 'Data is Updating',
        desc: 'Please be patent not Press back',
      )
        ..show();

      // tagsSelected
      Dio dio = await Api().getApiClient("${Application.user.token}");
      var map = {
        "id": dataListModel.id,
        "name": titleController.text,
        "country": "${active_country.id}",
        "state": "${active_state.id}",
        "location": "${active_city.id}",
        "address": addressController.text,
        "postalcode": pincodeController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "website": websiteController.text,
        "date_picker": getDate(), //todo
        "min_price": "1500", //todo
        "max_price": "25000", //todo
        "latitude": locationProvider.markers.first.position.latitude, //todo
        "longitude": locationProvider.markers.first.position.longitude, //todo
        "status": "Active", //todo
        "excerpt": exceptController.text,
        "fb": facebookController.text,
        "twitter": twitterController.text,
        "pinterest": pinterestController.text,
        "linkedin": linkedinController.text,
        "instagram": instagramController.text,
        "youtube": youtubeController.text,
        "m_s_time": "9:00 am",
        "m_e_time": "6:00 pm",
        "t_s_time": "9:00 am",
        "t_e_time": "6:00 pm",
        "w_s_time": "9:00 am",
        "w_e_time": "6:00 pm",
        "th_s_time": "9:00 am",
        "th_e_time": "6:00 pm",
        "f_s_time": "9:00 am",
        "f_e_time": "6:00 pm",
        "sat_s_time": "9:00 am",
        "sat_e_time": "6:00 pm",
        "sun_s_time": "9:00 am",
        "sun_e_time": "6:00 pm",

        "tags": jsonEncode(tags_list),
        "features": jsonEncode(feature_list),
        "category": choosen_category.id,
        "files": multipartImageList,
        //  "image":primary_image,
        "image": primary_image,
      };

      var formdata = FormData.fromMap(map);
      Response resp;
      try {
        resp = await dio.post("/update_listing", data: formdata);
      } on SocketException catch (e) {
        AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            title: 'Internet Error',
            desc: 'No Internet',
            btnOkOnPress: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: () {
              debugPrint('Dialog Dissmiss from callback');
            })
          ..show();
      }

      if (resp.statusCode == 200) {
        AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            title: 'Success',
            desc: 'Your Data is Uploaded Successfully',
            btnOkOnPress: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: () {
              debugPrint('Dialog Dissmiss from callback');
            })
          ..show();
      } else {
        AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.RIGHSLIDE,
            headerAnimationLoop: false,
            title: 'Error',
            desc: 'There is error during upload please try sometime later',
            btnOkOnPress: () {
              Navigator.pop(context);
            },
            btnOkIcon: Icons.cancel,
            btnOkColor: Colors.red)
          ..show();
      }
    }
  }

  void setFeature() async {
    for(CategoryClass item in productDetail.data.features) {
      featureSelected.add(DataFeature(id:item.termId,name: item.name));
      selectedFeatureText+="${item.name}, ";
    }
  }

  void setTags() async {
    for(Tag item in productDetail.data.tags) {
      tagsSelected.add(DataFeature(id:item.termId,name: item.name));
      selectedTagsText+="${item.name}, ";
    }
  }



/*  void setTags() async {

    for(CategoryClass item in productDetail.data.t) {
      featureSelected.add(DataFeature(id:item.termId,name: item.name));
      selectedFeatureText+="${item.name},";
    }
  }*/

/*
  10.Update listing
POST Method
Url:https://naxosoft.com/projects/itsme4u/api/update_listing
Variables:
name:Mehfil Restaurant
country:108
state:109
location:114
address:hyderabad warAGAL
postalcode:500082
phone:8328473790
email:BALU@GMAIL.CO0M
website:WWW.HOTSTASR.COM
date_picker:20-08-2020
min_price:1500
max_price:25000
latitude:27.2046
longitude:77.4977
status:Active
excerpt:excerpt
fb:fb
twitter:twitter
pinterest:pinterest
linkedin:linkedin
instagram:instagram
youtube:youtube
m_s_time:9:00 am
m_e_time:6:00 pm
t_s_time:9:00 am
t_e_time:6:00 pm
w_s_time:9:00 am
w_e_time:6:00 pm
th_s_time:9:00 am
th_e_time:6:00 pm
f_s_time:9:00 am
f_e_time:6:00 pm
sat_s_time:9:00 am
sat_e_time:6:00 pm
sun_s_time:9:00 am
sun_e_time:6:00 pm
tags:[119,120]
features:[120,119]
category:126
id:91
image:image
files[]:multiple files




  */

}
