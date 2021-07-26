import 'package:flutter/material.dart';

class MyConstant {
  // Genernal
  static String appName = 'ส.ป.ก.สระบุรี';
 // static String domain = 'https://95549f455b8d.ngrok.io';
  static String domain = 'https://songsuk.alro.go.th';

  static String keyId = 'id';
  static String keyType = 'Type';
  static String keyName = 'Name';
  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeCreatePoint = '/createPoint';
  static String routeAddPoint = '/addPoint';
  static String routeMyService = '/myService';
  static String routeGeneralService = '/generalService';
  static String routeAuthoritiesService = '/authoritiesService';
  static String routeManageService = '/manageService';
  
  static String routeRiderService = '/riderService';
  static String routeAddProduct = '/addProduct';

  // Image
  static String image1 = 'images/image1.png';
  static String image2 = 'images/image2.png';
  static String image3 = 'images/image3.png';
  static String image4 = 'images/image4.png';
  static String image5 = 'images/image5.png';
  static String avatar = 'images/avatar.png';
  static String request = 'images/request.png';

  // Color
  static Color primary = Color(0xff87861d);
  static Color dark = Color(0xff575900);
  static Color light = Color(0xffb9b64e);
  static Map<int, Color> mapMaterialColor = {
    50: Color.fromRGBO(255, 87, 89, 0.1),
    100: Color.fromRGBO(255, 87, 89, 0.2),
    200: Color.fromRGBO(255, 87, 89, 0.3),
    300: Color.fromRGBO(255, 87, 89, 0.4),
    400: Color.fromRGBO(255, 87, 89, 0.5),
    500: Color.fromRGBO(255, 87, 89, 0.6),
    600: Color.fromRGBO(255, 87, 89, 0.7),
    700: Color.fromRGBO(255, 87, 89, 0.8),
    800: Color.fromRGBO(255, 87, 89, 0.9),
    900: Color.fromRGBO(255, 87, 89, 1.0),
  };

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h2WhiteStyle() => TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h3WhiteStyle() => TextStyle(
        fontSize: 14,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );
  BoxDecoration myBoxDecoration(String namePic) {
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/Surveyor.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
  Container showLogo() {
    return Container(
      width: 120.0,
      child: Image.asset('images/image4.png'),
    );
  }
      
}
