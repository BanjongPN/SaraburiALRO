import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:saraburialro/states/add_product.dart';
import 'package:saraburialro/states/authen.dart';
import 'package:saraburialro/states/general_service.dart';
import 'package:saraburialro/states/create_account.dart';
import 'package:saraburialro/states/information_point.dart';
import 'package:saraburialro/states/create_point.dart';
import 'package:saraburialro/states/my_service.dart';
import 'package:saraburialro/states/rider_service.dart';
import 'package:saraburialro/states/authorities_service.dart';
import 'package:saraburialro/states/manage_service.dart';
import 'package:saraburialro/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/createPoint': (BuildContext context) => CreatePoint(),
  '/addPoint': (BuildContext context) => AddPoint(),
  '/myService': (BuildContext context) => MyService(),
  '/generalService': (BuildContext context) => GeneralService(),
  '/authoritiesService': (BuildContext context) => AuthoritiesService(),
  '/manageService': (BuildContext context) => ManageService(),
  '/riderService': (BuildContext context) => RiderService(),
  '/addProduct': (BuildContext context) => AddProduct(),
};

String? initlalRoute;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? type = preferences.getString('type');
  print('### type ===>> $type');
  if (type?.isEmpty ?? true) {
    initlalRoute = MyConstant.routeAuthen;
    runApp(MyApp());
  } else {
    switch (type) {
      case 'general':
        initlalRoute = MyConstant.routeGeneralService;
        runApp(MyApp());
        break;
      case 'manage':
        initlalRoute = MyConstant.routeManageService;
        runApp(MyApp());
        break;
      case 'authorities':
        initlalRoute = MyConstant.routeAuthoritiesService;
        runApp(MyApp());
        break;
      default:
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor materialColor =
        MaterialColor(0xff575900, MyConstant.mapMaterialColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
      theme: ThemeData(
          fontFamily: 'Prompt',
          // brightness: Brightness.dark,
          primarySwatch: materialColor),
      //theme: ThemeData(primarySwatch: materialColor),
    );
  }
}
