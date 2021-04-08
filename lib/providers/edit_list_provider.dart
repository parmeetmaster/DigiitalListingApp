import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/api/api.dart';
import 'package:listar_flutter_pro/configs/application.dart';
import 'package:listar_flutter_pro/configs/constants.dart';
import 'package:listar_flutter_pro/models/edit_listing/listing_item_model.dart';
import 'package:listar_flutter_pro/utils/toast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EditListProvider extends ChangeNotifier {
  dynamic currunt_state = appstate.defaultstate;
  int index = 1;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  List<DataListModel> ls;

  init() async {
    Dio dio = await Api().getApiClient(Application.user.token);
    Response resp = await dio.get("/user_list?page=$index");
    ls = LIstingItemModel.fromJson(resp.data).data;

    print("code is ${ls.length}");
    currunt_state = appstate.laoding_complete;
    notifyListeners();
  }

  void onLoading() async {
    print("on loading called${index}");
    Dio dio = await Api().getApiClient(Application.user.token);
    Response resp = await dio.get("/user_list?page=${++index}");
    List<DataListModel> templs = LIstingItemModel.fromJson(resp.data).data;
    if (templs != null && templs.length > 0) ls.addAll(templs);
    print("onloading");
    notifyListeners();
  }

  onRefresh() async {
    index = 1;
    await init();
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  void deleteItem({DataListModel dataListModel}) async {
    Dio dio = await Api().getApiClient(Application.user.token);
    var map = {
      "id": dataListModel.id,
    };

    var formdata = FormData.fromMap(map);

    Response resp = await dio.post("/delete_listing", data: formdata);
    if (resp.statusCode == 200) {
      await init();
    }
  }
}
