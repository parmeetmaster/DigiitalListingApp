import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
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

import 'location_provider.dart';

class AddListItemProvider extends ChangeNotifier {
  CategoryData catagories;
  CategoryDataItem choosen_category;
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
  List<Asset> secondary_imges = List<Asset>();
  List<Asset> primaryImages = List<Asset>();
  final picker = ImagePicker();
  File profileImage;

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

  reset(){
     catagories=null;
     choosen_category=null;
     featureModel=null;
     tagsModel=null;
   featureSelected = [];
  tagsSelected = [];
     currunt_state = appstate.defaultstate;
     feature_items=null;
     tags_items=null;
     countries=null;
     state=null;
     cities=null;
     active_country=null;
     active_state=null;
     active_city=null;
    skey;
   images = List<Asset>();
     _error = 'No Error Dectected';
   secondary_imges = List<Asset>();
     primaryImages = List<Asset>();

     profileImage=null;

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
        showtoast(skey, "Location not detected");
        return;
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
      if (profileImage.path.split('/').last == null) {
        showtoast(skey, "No Image selected");
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
          /*    ByteData byteData = await asset.getByteData();
        List<int> imageData =  byteData.buffer.asUint8List();
        MultipartFile multipartFile =  new MultipartFile.fromBytes(
          imageData,
          filename: 'load_image.jpg',
        contentType: MediaType("image", "jpg"),
        );
        multipartImageList.add(multipartFile);*/
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
        title: 'Data is Uploading',
        desc: 'Please be patent not Press back',
      )
        ..show();



      Dio dio = await Api().getApiClient("${Application.user.token}");
      var map = {
        "name": titleController.text,
      /*  "country": countryController.text,
        "state": stateController.text,
        "state": stateController.text,
        "location": cityController.text,*/
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
        "youtube": youtubeController.text,
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
         resp = await dio.post("/add_listing", data: formdata);
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
}
