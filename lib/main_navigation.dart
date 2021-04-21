import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/screens/message/message.dart';
import 'package:listar_flutter_pro/screens/notifications/notifications.dart';
import 'package:listar_flutter_pro/screens/screen.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
class MainNavigation extends StatefulWidget {
  MainNavigation({Key key}) : super(key: key);

  @override
  _MainNavigationState createState() {
    return _MainNavigationState();
  }
}

class _MainNavigationState extends State<MainNavigation> {
  final _fcm = FirebaseMessaging();
  int _selectedIndex = 0;
  String menu;
  @override
  void initState() {
    _fcmHandle();
    super.initState();
  }

  ///Handle When Press Notification
  void _notificationHandle(Map<String, dynamic> message) {
    final notification = NotificationModel.fromJson(message);
    switch (notification.action) {
      case NotificationAction.created:
        Navigator.pushNamed(
          context,
          Routes.productDetail,
          arguments: notification.id,
        );
        return;

      default:
        return;
    }
  }

  ///Support Notification listen
  void _fcmHandle() async {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        _notificationHandle(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        _notificationHandle(message);
      },
      onResume: (Map<String, dynamic> message) async {
        _notificationHandle(message);
      },
    );
  }

  ///On change tab bottom menu
  void _onItemTapped({int index, bool requireLogin}) async
  {
    if (requireLogin && (index == 1 || index == 2  || index == 3 || index == 4))
    {
      if(_selectedIndex == 1)
      {
        menu=Routes.wishList;
      }
      else if(_selectedIndex == 3)
      {
        menu=Routes.message;
      }
      else if(_selectedIndex == 2)
      {
        menu=Routes.account;
      }
      else if(_selectedIndex == 4)
      {
        menu=Routes.notifications;
      }

      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: menu);

      switch (result)
      {
        case Routes.wishList:
          index = 1;
          break;
        case Routes.message:
          index = 3;
          break;
        case Routes.account:
          index = 2;
          break;
        case Routes.notifications:
          index = 4;
          break;
        default:
          return;
      }
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  ///List bottom menu
  List<BottomNavigationBarItem> _bottomBarItem(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: Translate.of(context).translate('home'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.bookmark),
        label: Translate.of(context).translate('wish_list'),
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.person_add_alt_1),// person parmeet change
        label: Translate.of(context).translate("Add Vendor"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        label: Translate.of(context).translate("notifications"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: Translate.of(context).translate('account'),
      ),


    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthenticationState>(
      listener: (context, state) async {
        if (state is AuthenticationFail &&
            (_selectedIndex == 1 || _selectedIndex == 2  ||  _selectedIndex == 3 || _selectedIndex == 4))
        {
          if(_selectedIndex == 1)
          {
             menu=Routes.wishList;
          }
          else if(_selectedIndex == 3)
          {
            menu=Routes.message;
          }
          else if(_selectedIndex == 4)
          {
            menu=Routes.notifications;
          }
          else if(_selectedIndex == 2)
          {
            menu=Routes.account;
          }
          final result = await Navigator.pushNamed(
            context,
            Routes.signIn,
            arguments: menu,
          );
          if (result == null) {
            setState(() {
              _selectedIndex = 0;
            });
          }
        }
      },
      child: BlocBuilder<AuthBloc, AuthenticationState>(
        builder: (context, state) {
          final requireLogin = state is AuthenticationFail;
          return Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: <Widget>[Home(), WishList(), AddVendorScreen() , Notifications(),Profile()],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: _bottomBarItem(context),

              currentIndex: _selectedIndex,

              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Theme.of(context).unselectedWidgetColor,
              selectedItemColor: Theme.of(context).primaryColor,
              showUnselectedLabels: true,
              onTap: (index) {
                _onItemTapped(index: index, requireLogin: requireLogin);
              },
            ),
          );
        },
      ),
    );
  }
}