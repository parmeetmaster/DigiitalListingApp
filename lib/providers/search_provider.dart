import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:listar_flutter_pro/models/lisiting-item/category_model.dart';
import 'package:listar_flutter_pro/models/lisiting-item/tag_model.dart';
import 'package:listar_flutter_pro/models/model_product.dart';
import 'package:listar_flutter_pro/screens/product_detail/product_detail.dart';
import 'package:listar_flutter_pro/utils/toast.dart';
import 'package:select_dialog/select_dialog.dart';

class SearchProvider extends ChangeNotifier {
  var searchExpanded;
   dynamic state=appstate.defaultstate;

  BuildContext context;
  TextEditingController searchinputController = new TextEditingController();
  TextEditingController categoryEditingController = new TextEditingController();
  TextEditingController cityEditingController = new TextEditingController();

  CategoryData catagories;
  CategoryDataItem choosen_category;
  CommonListingModel cities;
  DataItems choosen_city;
  List<ProductModel> search_list;
  GlobalKey<ScaffoldState> skey;

  reset(){
     state=appstate.defaultstate;
    BuildContext context;
     searchinputController = new TextEditingController();
     categoryEditingController = new TextEditingController();
     cityEditingController = new TextEditingController();

     catagories=null;
     choosen_category;
     cities=null;
     choosen_city=null;
     search_list=null;
  }


  loadData() async {
    dynamic category_resp;
    Response cities_resp;

    await Future.wait([Api().getCategoriesForListing(), Api().getCities()])
        .then((List resp) {
      category_resp = resp[0];
      cities_resp = resp[1];
    });

    catagories = CategoryData.fromJson(category_resp);
    cities = CommonListingModel.fromJson(cities_resp.data);

    notifyListeners();
  }

  onClickCategory() {
    print("on click category");
    SelectDialog.showModal<String>(
      context,
      label: "Select Category",
      selectedValue: "None",
      items: List.generate(
          catagories.data.length, (index) => "${catagories.data[index].name}"),
      onChange: (String selected) {
        int index = catagories.data.indexWhere((data) => data.name == selected);
        categoryEditingController.text = catagories.data[index].name;
        choosen_category = catagories.data[index];
      },
    );

    notifyListeners();
  }

  onClickCity() {
    print("on click cities");
    SelectDialog.showModal<String>(
      context,
      label: "Select Cities",
      selectedValue: "None",
      items: List.generate(
          cities.data.length, (index) => "${cities.data[index].name}"),
      onChange: (String selected) {
        int index = cities.data.indexWhere((data) => data.name == selected);
        cityEditingController.text = cities.data[index].name;
        choosen_city = cities.data[index];
        notifyListeners();
      },
    );
  }

  void submit() async {
    state=appstate.defaultstate;
    if(choosen_city==null || searchinputController.text.isEmpty || choosen_category==null){

      showtoast(skey,"Please Provder all values for Search Opertation");
    return;
    }



    EasyLoading.init();
    EasyLoading.show();

    Response resp = await Api().getSearchResult(
        choosen_category.id, choosen_city.id, searchinputController.text);
    List<dynamic> ls = resp.data["data"];
    search_list = [];

    for (dynamic item in ls) {
      search_list.add(ProductModel.fromJson(item));
    }
    EasyLoading.dismiss();
  notifyListeners();
    state=appstate.laoding_complete;
  }
}
